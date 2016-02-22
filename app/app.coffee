Router =            require './router'
AppView =           require './views/appview'
TextCollection =    require './models/textcollection'

module.exports = class App

    start: =>
        @textCollection = new TextCollection()
        @appView = new AppView { collection: @textCollection }
        
        @textCollection.fetch
            success: () =>
                @appView.render()
            error: () ->
                throw new Error 'Could not fetch data from server.'
        
        @router = new Router()
        Backbone.history.start { pushState: true }
