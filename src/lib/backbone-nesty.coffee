# Import
typeChecker = require('typechecker')
getSetDeep = require('getsetdeep')
{Model} = require('backbone')

# Extend our Backbone.Model with our own custom stuff
class BackboneNestyModel extends Model
	# Prepare
	strict: true

	# Constructor
	constructor: ->
		# Destroy References
		@defaults = JSON.parse JSON.stringify (@defaults or {})
		@collections ?= {}
		@models ?= {}
		@embeds ?= {}

		# Ensure attributes exist in defaults
		things = ['embeds', 'models', 'collections']
		for thing in things
			for own key,value of @[thing]
				getSetDeep.setDeep(@defaults,key,null,true)

		# Super
		super

	# Ensure Value
	prepareValue: (key,value) ->
		# Prepare
		klass = null
		type = null

		# Model
		if key of @models
			klass = @models[key]
			type = 'model'

		# Collection
		else if key of @collections
			klass = @collections[key]
			type = 'collection'

		# Handle
		if type? and !(value instanceof klass)
			# Collection
			if type is 'collection'
				if typeChecker.isArray(value) is false
					# Convert id indexed object into an array
					items = []
					for own id,item of value
						item.id ?= id
						items.push(item)
					value = items

			# Instantiate value with our desired class
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
		things = ['models','collections']
		json = super

		# Instantiate
		for thing in things
			thingy = @[thing]
			for own key,klass of thingy
				value = getSetDeep.getDeep(json,key)
				embed = @embeds?[key] ? null

				# Shallow Embed
				if embed is 'shallow'
					if thing is 'collections'
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
		return @prepareValue key, getSetDeep.getDeep(@attributes,key)

	# Set
	# If our model is strict, then only set attributes that actually exist in our model structure
	set: (args...) ->
		# Prepare
		model = @

		# Check
		if args.length is 2 and typeChecker.isString(args[0])
			[key,value] = args
			attrs = {}
			attrs[key] = value
			return @set(attrs)

		# Apply
		[attrs,opts] = args
		for own key,value of attrs
			# Strict Attributes
			if @strict and (typeof getSetDeep.getDeep(@defaults,key) is 'undefined' and (key in ['id','cid']) is false)
				console.log("Set of #{key} ignored on strict model #{model.className}")
				continue

			# Deep Attributes
			value = model.prepareValue(key, value)
			getSetDeep.setDeep(model.attributes, key, value)
			event = "change:#{key}"
			@trigger(event, @, value)

			# Special
			@id  = value  if key is 'id'
			@cid = value  if key is 'cid'

			# Done
			continue

		# Native
		return @

# Export
module.exports = {
	BackboneNestyModel
}