###
 * grunt-hazy
 * https://github.com/ralphcrisostomo/grunt-hazy
 *
 * Copyright (c) 2014 Ralph Crisostomo
 * Licensed under the MIT license.
###

'use strick'

module.exports = (grunt) ->

  Hazy = require('./lib/hazy').init(grunt)

  # Please see the Grunt documentation for more information regarding task
  # creation: http://gruntjs.com/creating-tasks

  # ----------
  # REGISTER HAZY TASK
  # ----------
  grunt.registerMultiTask 'hazy', 'Thet best Grunt plugin ever.', ->
    new Hazy(@)

