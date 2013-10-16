# Import
typeChecker = require('typechecker')
getSetDeep = require('getsetdeep')
{Model} = require('backbone')

# Derference helper
dereference = (obj) ->
	return JSON.parse(JSON.stringify(obj or {}))

# Extend our Backbone.Model with our own custom stuff
class BackboneNestyModel extends Model
	# Prepare
	collections: null
	models: null
	embeds: null
	strict: true
	dereference: true

	# Constructor
	constructor: (attrs,opts={}) ->
		# Options
		@strict = opts.strict  if opts.strict

		# Destroy References
		@collections ?= {}
		@models ?= {}
		@embeds ?= {}
		@defaults = dereference(@defaults or {})

		# Super
		super

	# Check if the key is an id attribute
	isIdAttribute: (key) =>
		return key in ['id', 'cid']

	# Check if the key is a nested attribute
	isNestedAttribute: (key) =>
		types = ['models', 'collections']
		for type in types
			typeCollection = @[type]
			return type  if key of typeCollection
		return false

	# Check if the value is a prepared value
	isPreparedValue: (key,value) ->
		# Prepare
		type = @isNestedAttribute(key)
		return null  unless type
		klass = @[type][key]
		return value instanceof klass

	# Ensure Value
	prepareValue: (key,value,options,opts={}) =>
		# Options
		opts.idindexed ?= true
		opts.instantiate ?= true

		# Prepare
		type = @isNestedAttribute(key)
		return value  unless type
		klass = @[type][key]
		return value  if value instanceof klass

		# Prepare the collection
		if type is 'collections'
			if opts.idindexed and typeChecker.isArray(value) is false
				# Convert id indexed object into an array
				items = []
				for own id,item of value
					item.id ?= id
					items.push(item)
				value = items

		# Instantiate the value with our desired class
		if opts.instantiate
			value =
				if klass is Array
					value or []
				else if value?
					new klass(value, options)
				else
					new klass()

		# Return the prepare value
		return value

	# To JSON
	toJSON: =>
		# Prepare
		model = @
		types = ['models','collections']
		json = dereference(super)
		json.id = @id

		# Instantiate
		for type in types
			typeCollection = @[type]
			for own key,klass of typeCollection
				value = @get(key)
				embed = @embeds?[key] ? null

				# Shallow Embed
				if embed is 'shallow'
					if type is 'collections'
						value = value?.pluck?('id') ? value[key]
						getSetDeep.setDeep(json, key, value)
					else
						value = value?.id ? value[key]
						getSetDeep.setDeep(json, key, value)

				# No Embed
				else if embed is false
					getSetDeep.setDeep(json, key, undefined)

				# Normal
				else
					value = value.toJSON()  if value?.toJSON?
					getSetDeep.setDeep(json, key, value)

		# Return
		return json

	# Get
	get: (key,opts) =>
		# Prepare
		value = getSetDeep.getDeep(@attributes, key)
		preparedValue = @prepareValue(key, value, {parse:opts?.parse})

		# Changed?
		if value isnt preparedValue
			# Apply
			getSetDeep.setDeep(@attributes, key, preparedValue, opts)

			# Done
			event = "change:#{key}"
			@trigger(event, @, value)

		# Return
		return preparedValue

	# Set
	# If our model is strict, then only set attributes that actually exist in our model structure
	set: (attrs,opts) =>
		# Handle alternative argument cases
		if arguments.length is 3 or typeChecker.isString(arguments[0])
			[key,value,opts] = arguments
			attrs = {}
			attrs[key] = value
			return @set(attrs,opts)

		# Prepare
		opts ?= {}
		opts.replaceModel ?= true

		# Apply
		for own key,value of attrs
			# ID Attribute
			if @isIdAttribute(key)
				@[key] = value

			# Nested Attribute
			else if @isNestedAttribute(key.split('.')[0])
				nestedValue = getSetDeep.getDeep(@attributes, key)

				# Do we not want to replace the model if it is a model?
				isPreparedValue = @isPreparedValue(key,value)
				if opts.replaceModel is false
					value = value.toJSON()
					isPreparedValue = false

				# If we are a model, we want to replace the model with the new model, not write inside it
				if isPreparedValue is false and nestedValue?.set?
					# support nested collections and models
					value = @prepareValue(key, value, {parse:opts?.parse}, {instantiate:false})
					nestedValue.set(value, opts)
				else
					# support nested arrays, objects etc
					value = @prepareValue(key, value, {parse:opts?.parse})
					getSetDeep.setDeep(@attributes, key, value, opts)

			# Normal/Deep Attribute
			else
				# Strict and doens't exist
				if @strict and typeof getSetDeep.getDeep(@defaults,key) is 'undefined'
					err = new Error("Set of #{key} ignored on strict model")
					@trigger('warn', err)
					continue

				# Ohterwise proceed with set
				getSetDeep.setDeep(@attributes, key, value, opts)

			# Done
			event = "change:#{key}"
			@trigger(event, @, value)

		# Native
		return @

# Export
module.exports = {
	BackboneNestyModel
}