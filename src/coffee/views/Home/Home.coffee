$ = require 'jquery'
B = require 'baconjs'
{View} = require 'backbone'
todos = require '../../state/todos.coffee'

getTodoItem = (todoModel) ->
	"""
	<li class='list-group-item'>
		<input
			class='form-control'
			type='text'
			data-role="editTodo"
			data-target='#{todoModel.cid}'
			value='#{todoModel.get 'title'}'
		/>
		<button
			class='btn btn-danger'
			data-role='removeTodo'
			data-target="#{todoModel.cid}"
		>
			X
		</button>
	</li>
	"""

class Home extends View

	template: require './Home.html'

	render: ->
		@$el.html @template

		onAddTodo = @$el.asEventStream 'click', '[data-role="addTodo"]'
			.map (e) =>
				{
					action: 'ADD_TODO'
					model: {
						title: 'New Todo'
						category: 1
						completed: false
					}
				}

		onEditTodo = @$el.asEventStream 'change', '[data-role="editTodo"]'
			.map (e) =>
				{
					action: 'EDIT_TODO'
					model: todos.get e.target.getAttribute('data-target')
					newTitle: e.target.value
				}

		onRemoveTodo = @$el.asEventStream 'click', '[data-role="removeTodo"]'
			.map (model) =>
				{
					action: 'REMOVE_TODO'
					model: todos.get e.target.getAttribute('data-target')
				}

		subscription =
			onAddTodo
			.merge(onRemoveTodo)
			.merge(onEditTodo)
			.onValue (payload) =>
				switch payload.action

					when 'ADD_TODO'
						todos.add payload.model

					when 'EDIT_TODO'
						todos
							.get payload.model
							.set 'title', payload.newTitle

					when 'REMOVE_TODO'
						todos.remove payload.model


		todos.on 'update change', onStateChange = () =>
			@$('[data-role="todoList"]').html todos.models.map getTodoItem

		@cleanup = () ->
			subscription()
			todos.off 'update change', onStateChange

		onStateChange()

	remove: ->
		@cleanup()
		@$el.empty()

module.exports = Home
