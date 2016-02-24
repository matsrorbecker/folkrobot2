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
        choice = $('#municipality').val().toLowerCase().trim()
        textModel = @collection.find (model) ->
            model.get('municipality').toLowerCase() == choice
        @renderText textModel

    renderText: (textModel) =>
        $('#text').empty()
        @resetForm()
        if textModel
            textView = new TextView { model: textModel, totals: app.totals }
            $('#text').append textView.render().el
        else
            $('#text').append "<p>Det finns ingen kommun som heter så. Försök igen.</p>"

    clearForm: ->
        $('#municipality').val ''

    resetForm: ->
        $('#municipality').val('Ange en kommun').blur()