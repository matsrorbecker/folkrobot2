"use strict"
gulp = require "gulp"
browserify = require "gulp-browserify"
jadeify = require "jadeify"
coffeeify = require "coffeeify"
transform = require "vinyl-transform"
concat = require "gulp-concat"
uglify = require "gulp-uglify"
mainBowerFiles = require "main-bower-files"
browserSync = (require "browser-sync")
gulpFilter = require "gulp-filter"

# CONSTANTS
APP = "./app"
APPDEST = './public'
OUTPUT = "app.js"

# TASKS 

## t o o l

gulp.task 'default', [ "build" ]

gulp.task "build", ["static", "styles", "vendor", "scripts"]

# copy static files from assets
gulp.task "static", ->

  files = [
      "#{APP}/assets/**/*.*"
  ]
  gulp.src files
    .pipe gulp.dest "#{APPDEST}"
    .pipe(browserSync.stream())

# CSS
gulp.task "styles", ->

    gulp.src ["#{APP}/**/*.css"]
        .pipe concat "app.css"
        .pipe gulp.dest "#{APPDEST}/stylesheets"
        .pipe(browserSync.stream())

# coffeescript and jade templates
gulp.task "scripts", (cb) ->

  gulp.src("./#{APP}/init.coffee", { read: false })
   .pipe(browserify({ transform: ['coffeeify', 'jadeify'], extensions: ['.coffee', '.jade'] }))
   .pipe(concat('app.js'))
   .pipe(gulp.dest("./#{APPDEST}/javascripts"))
   .pipe(browserSync.stream())

gulp.task "vendor", ->

  jsFilter = gulpFilter "**/*.js", restore: true
  cssFilter = gulpFilter "**/*.css", restore: true
  gulp.src(mainBowerFiles(), { base: './bower_components' })
    .pipe jsFilter
    .pipe concat "vendor.js"
    .pipe uglify()
    .pipe gulp.dest "#{APPDEST}/javascripts"
    .pipe jsFilter.restore
    .pipe cssFilter
    .pipe concat "vendor.css"
    .pipe gulp.dest "#{APPDEST}/stylesheets"
    .pipe cssFilter.restore