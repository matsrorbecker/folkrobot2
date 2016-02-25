module.exports = config:
    files:
        javascripts: 
            defaultExtension: 'coffee'
            joinTo:
                'javascripts/app.js': /^app/
                'javascripts/vendor.js': /^(vendor|bower_components)/

        stylesheets: 
            joinTo: 
                'stylesheets/app.css': /^app/

        templates:
            defaultExtension: 'jade'
            joinTo:
                'javascripts/templates.js'

    paths:
        watched: ['app']

    plugins:
        coffeelint:
            pattern: /^app\/.*\.coffee$/
            options:
                no_unnecessary_fat_arrows:
                    level: 'ignore'
                indentation:
                    level: 'ignore'