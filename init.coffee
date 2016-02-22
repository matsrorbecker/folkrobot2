App = require './app'

$ ->
    app = window.app = new App()
    app.start()