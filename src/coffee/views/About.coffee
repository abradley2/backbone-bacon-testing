{View} = require 'backbone'

class About extends View

	template: """<div>
		<h3>About View</h3>
		<a href='#'>Home</a>
	</div>"""

	render: ->
		@$el.html @template

	remove: ->
		@$el.empty()

module.exports = About