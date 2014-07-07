###
 * grunt-hazy
 * https://github.com/ralphcrisostomo/grunt-hazy
 *
 * Copyright (c) 2014 Ralph Crisostomo
 * Licensed under the MIT license.
###
  
'use strict'

module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    coffee_jshint:
      all: [
        'Gruntfile.coffee'
        'tasks/*.coffee'
#        '<%= nodeunit.tests %>'
      ],
      options:
        jshintrc: '.jshintrc'
        globals: [
          'module'
          'require'
          'exports'
        ]

    # Before generating any new files, remove any previously-created files.
    clean: 
      tests: ['tmp']

    # Configuration to be run (and then tested).
    hazy: 
      default_options:
        options: {}
        files:
          'tmp/default_options.php': ['test/fixtures/sample.php']
      php:
        expand: true
        cwd:    'test/fixtures'
        dest:   'tmp'
        src:    [ '*.php' ]
      js:
        expand: true
        cwd:    'test/fixtures'
        dest:   'tmp'
        src:    [ '*.js' ]
      all:
        expand: true
        cwd:    'test/fixtures'
        dest:   'tmp'
        src:    [ '*.*' ]

    # Unit tests.
    nodeunit: 
      tests: ['test/*_test.coffee']

    # Bump version
    bump:
      options:
        push: false



  # Actually load this plugin's task(s).
  grunt.loadTasks('tasks') 

  # These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-coffee-jshint')
  grunt.loadNpmTasks('grunt-contrib-clean') 
  grunt.loadNpmTasks('grunt-contrib-nodeunit')
  grunt.loadNpmTasks('grunt-bump')

  # Whenever the "test" task is run, first clean the "tmp" dir, then run this
  # plugin's task(s), then test the result.
  grunt.registerTask('test', ['clean', 'hazy', 'nodeunit']) 

  # By default, lint and run all tests.
  grunt.registerTask('default', ['coffee_jshint', 'test' ])

  # Build with bump version
  grunt.registerTask('build', ['default', 'bump'])

