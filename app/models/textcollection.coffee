TextModel = require './textmodel'

module.exports = class TextCollection extends Backbone.Collection

    model: TextModel

    url: 'data/municipalities.json'