{Model, Collection} = require 'backbone'

class TodoModel extends Model
	defaults:
		title: 'New Todo'
		category: 1
		completed: false

class TodosCollection extends Collection
	model: TodoModel

	addTodo: =>
		@add new TodoModel()

	list: => @models


module.exports = new TodosCollection()