# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

template =
	caches: {}
	$: (name, data) -> $(@get(name)(data))
	get: (name) -> @caches[name] ||= Handlebars.compile $("#tmpl_#{name}").html()

class Joint extends Backbone.Model

class JointList extends Backbone.Collection
	model: Joint

class Inspection extends Backbone.Model

class InspectionList extends Backbone.Collection
	model: Inspection

class JointView extends Backbone.View
	tagName: 'li'
	className: 'joint'

	events: {}
	initialize: ->
	render: -> $(@el).html template.$("joint", @model.toJSON()); @

class AppView extends Backbone.View
	events:
		'click #find-places': 'find_places'
	
	initialize: ->
		_.bindAll @, 'find_places', 'add_all'

		@joints = new JointList
		@joints.bind("refresh", @add_all)
	
	add_all: ->
		@$("#joints").html ""
		@joints.each @add_one

	add_one: (joint) ->
		view = new JointView model: joint
		@$("#joints").append view.render().el

	find_places: ->
		if geo_position_js.init()
			# TODO: some kind of loading div.
			geo_position_js.getCurrentPosition ((position) =>
				# TODO: do ajax here
				$.ajax
					data:
						lat: position.coords.latitude
						long: position.coords.longitude
					url: '/joints/near'
					success: (data) =>
						@joints.refresh(data)
			), (->
				console.log "errors!"
				# TODO: show error message
			), enableHighAccuracy:true, maximumAge: 5 * 60 * 1000
		false

$ ->
	new AppView el: $("#container")

Handlebars.registerHelper 'inspection_class', (status) -> status.split(" ")[0].toLowerCase()
