ViewHelpers =   require './viewhelpers'

module.exports = class TextView extends Backbone.View

    template: require './tmpl/textview'

    initialize: (options) =>
        @totals = options.totals
        
    render: =>
        data = @model.toJSON()
        _.extend data, ViewHelpers
        _.extend data, @totals
        this.$el.html @template(data)
        this