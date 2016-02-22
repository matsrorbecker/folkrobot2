TextView = require './textview'

module.exports = class AppView extends Backbone.View
    
    el: $('#app')

    template: require './tmpl/appview'

    events:
        'submit form': 'validateChoice'
        'focus input': 'clearForm'

    render: =>
        this.$el.html @template
        this

    validateChoice: (event) => 
        event.preventDefault()
        choice = $('#municipality').val()
        textModel = @collection.find (model) ->
            model.get('municipality').toLowerCase() == choice.toLowerCase()
        @renderText textModel 

    renderText: (textModel) =>
        $('#text').empty()
        @resetForm()
        if textModel
            textView = new TextView { model: textModel }
            $('#text').append textView.render().el
        else
            $('#text').append "<p>Det finns ingen kommun som heter så. Försök igen.</p>"

    clearForm: ->
        $('#municipality').val ''

    resetForm: ->
        $('#municipality').val('Ange en kommun').blur()