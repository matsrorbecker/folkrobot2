module.exports = class TextView extends Backbone.View

    template: require './tmpl/textview'

    render: =>
        this.$el.html @template(@model.toJSON())
        this