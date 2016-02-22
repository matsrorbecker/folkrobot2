module.exports = config:
    files:
        javascripts: 
            defaultExtension: 'coffee'
            joinTo:
                'javascripts/app.js': /^app/
                'javascripts/vendor.js': /^bower_components/

        stylesheets: 
            joinTo: 
                'stylesheets/app.css': /^app/

        templates:
            defaultExtension: 'jade'
            joinTo:
                'javascripts/templates.js'

    plugins:
        coffeelint:
            pattern: /^app\/.*\.coffee$/
            options:
                no_unnecessary_fat_arrows:
                    level: 'ignore'
                indentation:
                    level: 'ignore'