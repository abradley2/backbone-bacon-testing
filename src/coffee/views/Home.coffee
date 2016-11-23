$ = require 'jquery'
B = require 'baconjs'
{View} = require 'Backbone'
todos = require '../state/Todos.coffee'

class Home extends View 
	
	template: """<div>
		<h3>Home View</h3>
		<a href='#about'>About</a>
		<div>
			<button class='btn btn-primary' data-role='addTodo'>
				Add Todo
			</button>
		</div>
		<div data-role='todos'></div>
	</div>"""

	render: ->
		@$el.html @template

		addTodo = $("[data-role='addTodo']")
			.asEventStream 'click'
			.onValue todos.addTodo.bind todos



	remove: ->
		@$el.empty()

module.exports = Home