# Import
typeChecker = require('typechecker')
getSetDeep = require('getsetdeep')
{Model} = require('backbone')

# Extend our Backbone.Model with our own custom stuff
class BackboneNestyModel extends Model
	# Prepare
	collections: null
	models: null
	embeds: null
	strict: true
	className: 'BackboneNestyModel'

	# Constructor
	constructor: ->
		# Destroy References
		@collections ?= {}
		@models ?= {}
		@embeds ?= {}

		# Super
		super

	# Check if the key is an id attribute
	isIdAttribute: (key) ->
		return key in ['id', 'cid']

	# Check if the key is a nested attribute
	isNestedAttribute: (key) ->
		types = ['models', 'collections']
		for type in types
			typeCollection = @[type]
			return type  if key of typeCollection
		return false

	# Ensure Value
	prepareValue: (key,value) ->
		# Prepare
		type = @isNestedAttribute(key)
		return value  unless type
		klass = @[type][key]
		return value  if value instanceof klass

		# Prepare the collection
		if type is 'collections'
			if typeChecker.isArray(value) is false
				# Convert id indexed object into an array
				items = []
				for own id,item of value
					item.id ?= id
					items.push(item)
				value = items

		# Instantiate the value with our desired class
		value =
			if klass is Array
				value or []
			else if value?
				new klass(value)
			else
				new klass()

		# Return the prepare value
		return value

	# To JSON
	toJSON: ->
		# Prepare
		model = @
		types = ['models','collections']
		json = super

		# Instantiate
		for type in types
			typeCollection = @[type]
			for own key,klass of typeCollection
				value = getSetDeep.getDeep(json, key)
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
	get: (key) ->
		value = getSetDeep.getDeep(@attributes, key)
		value = @prepareValue(key, value)
		return value

	# Set
	# If our model is strict, then only set attributes that actually exist in our model structure
	set: (attrs,opts) ->
		# Handle alternative argument cases
		if arguments.length is 3 or typeChecker.isString(arguments[0])
			[key,value,opts] = arguments
			attrs = {}
			attrs[key] = value
			return @set(attrs,opts)

		# Apply
		for own key,value of attrs
			# ID Attribute
			if @isIdAttribute(key)
				@[key] = value

			# Nested Attribute
			else if @isNestedAttribute(key.split('.')[0])  # not nice
				value = @prepareValue(key, value)
				getSetDeep.setDeep(@attributes, key, value, opts)

			# Normal/Deep Attribute
			else
				# Strict and doens't exist
				if @strict and typeof getSetDeep.getDeep(@defaults,key) is 'undefined'
					console.log("Set of #{key} ignored on strict model #{@className}")
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