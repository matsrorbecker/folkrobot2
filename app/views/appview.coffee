TextView =      require './textview'

module.exports = class AppView extends Backbone.View
    
    el: $('#app')

    template: require './tmpl/appview'

    events:
        'submit form': 'validateChoice'
        'focus #municipality': 'clearForm'

    render: =>
        this.$el.html @template
        $('#municipality').autocomplete { source: app.municipalities }
        this

    validateChoice: (event) => 
        event.preventDefault()
        choice = $('#municipality').val()
        if choice.toLowerCase().trim() in app.municipalities
            textModel = @collection.find (model) ->
                model.get('municipality').toLowerCase() == choice
            @renderText textModel
        else
            @renderError "Det finns ingen kommun som heter #{choice}."

    renderText: (textModel) =>
        $('#text').empty()
        @resetForm()
        textView = new TextView { model: textModel, totals: app.totals }
        $('#text').append textView.render().el

    renderError: (message) =>
        $('#text').empty()
        @resetForm()
        $('#text').append "<p>#{message}</p>"

    clearForm: ->
        $('#municipality').val ''

    resetForm: ->
        $('#municipality').val('Ange en kommun').blur()