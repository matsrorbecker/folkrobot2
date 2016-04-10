Router =            require './router'
AppView =           require './views/appview'
TextCollection =    require './models/textcollection'

module.exports = class App

    start: =>
        @textCollection = new TextCollection()
        @appView = new AppView { collection: @textCollection }
        
        @textCollection.fetch
            success: () =>
                @initializeApp()
            error: () ->
                throw new Error 'Could not fetch data from server.'
        
        @router = new Router()
        Backbone.history.start { pushState: true }

    initializeApp: =>
        @municipalities = []
        @autocompleteList = []
        @textCollection.forEach (model) =>
            municipality = model.get 'municipality'
            @autocompleteList.push municipality
            @municipalities.push municipality.toLowerCase()
        @calculateTotals()
        @appView.render()

    calculateTotals: =>
        population = 0
        populationChange = 0
        largestIncrease = 0
        largestDecrease = 0
        winners = 0
        losers = 0

        for model in @textCollection.toJSON()
            population += model.total
            populationChange += model.change
            if model.change > 0
                winners++
                if model.changeInPercent > largestIncrease
                    largestIncrease = model.changeInPercent
            if model.change < 0
                losers++
                if model.changeInPercent < largestDecrease
                    largestDecrease = model.changeInPercent
        
        averageChange = parseFloat ((populationChange / (population - populationChange)) * 100).toFixed(1)

        @totals =
            largestIncrease: largestIncrease
            largestDecrease: largestDecrease
            winners: winners
            losers: losers
            averageChange: averageChange