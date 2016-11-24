{View} = require 'backbone'

class About extends View

	template: require './About.html'

	render: ->
		@$el.html @template

	remove: ->
		@$el.empty()

module.exports = About
