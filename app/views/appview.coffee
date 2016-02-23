TextView =      require './textview'

module.exports = class AppView extends Backbone.View
    
    el: $('#app')

    template: require './tmpl/appview'

    events:
        'submit form': 'validateChoice'
        'focus input': 'clearForm'

    calculateTotals: =>
        population = 0
        populationChange = 0
        largestIncrease = 0
        largestDecrease = 0
        winners = 0
        losers = 0

        for model in @collection.toJSON()
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

    render: =>
        this.$el.html @template
        this

    validateChoice: (event) => 
        event.preventDefault()
        choice = $('#municipality').val().toLowerCase().trim()
        textModel = @collection.find (model) ->
            model.get('municipality').toLowerCase() == choice
        @renderText textModel

    renderText: (textModel) =>
        $('#text').empty()
        @resetForm()
        if textModel
            textView = new TextView { model: textModel, totals: @totals }
            $('#text').append textView.render().el
        else
            $('#text').append "<p>Det finns ingen kommun som heter så. Försök igen.</p>"

    clearForm: ->
        $('#municipality').val ''

    resetForm: ->
        $('#municipality').val('Ange en kommun').blur()