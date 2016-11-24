{extend} = require 'underscore'
jQuery = require 'jquery'
$ = jQuery
B = require 'baconjs'
$.fn.asEventStream = B.$.asEventStream;
{Router, history} = require 'backbone'
ViewMediator = require 'backbone-view-mediator'

vm = new ViewMediator {
	el: '#app'
	layout: """
		<div>
			<div id='content-region'></div>
		</div>
	"""
	views:
		'HomeView': require './views/Home/Home.coffee'
		'AboutView': require './views/About/About.coffee'
}

class AppRouter extends Router
	routes:
		'': ->
			vm.render {
				'HomeView':
					region: '#content-region'
					params: {}
			}
		'about': ->
			vm.render {
				'AboutView':
					region: '#content-region'
					params: {}
			}


router = new AppRouter()

document.addEventListener 'DOMContentLoaded', => history.start()
