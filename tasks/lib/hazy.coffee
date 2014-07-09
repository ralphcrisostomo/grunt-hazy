###
 * grunt-hazy
 * https://github.com/ralphcrisostomo/grunt-hazy
 *
 * Copyright (c) 2014 Ralph Crisostomo
 * Licensed under the MIT license.
###

exports.init = (grunt) ->

  # ----------
  # REQUIRE
  # ----------
  JJEncode  = require('./jjencode')
  btoa      = require('btoa')
  path      = require('path')
  chalk     = require('chalk')
  _         = grunt.util._

  # ----------
  # CLASS
  # ----------
  class Hazy
    constructor: (@task) ->
      # Merge task-specific and/or target-specific options with these defaults.
      @options = @task.options
        separator: grunt.util.linefeed
        js_variable: '$'
        js_encoder: 'jjencode'

      # Process task files.
      @processFiles(@task.files)

    processFiles: (files) ->
      # Iterate over all specified file groups.
      files.forEach (f) =>
         string         = @getString(f.src)
         extname        = @getExtName(f.src)
         encoded_string = @getEncodedString(string, extname)

         # Write file
         @writeFile(f.dest, encoded_string) if encoded_string

    writeFile: (dest, encoded_string) ->
      # Write the destination file.
      grunt.file.write(dest, encoded_string)

      # Print a success message.
      grunt.log.writeln "File '#{chalk.yellow(dest)}' created."

    # --------------------
    # GET
    # --------------------
    getExtName: (file) ->
      extname = path.extname(file)
      grunt.log.warn "File '#{chalk.red(file)}' is invalid." if not @isValid(extname)
      extname

    getString: (src) ->
      src.filter (filepath) =>
        # Warn on and remove invalid source files (if nonull was set).
        if not grunt.file.exists(filepath)
          grunt.log.warn "Source file #{chalk.red(filepath)} not found."
          false
        else
          true
      .map (filepath) =>
        # Read file source.
        grunt.file.read(filepath)
      .join grunt.util.normalizelf(@options.separator)

    getEncodedString: (string, extname) ->
      # Encode by extension name
      encoded_string = false
      switch extname
        when '.php' then encoded_string = @getEncodedPHP string
        when '.js' then  encoded_string = @getEncodedJS string
      encoded_string

    getEncodedPHP: (string) ->
      # TODO - check if php tag is existing on file!
      base64  = btoa(string)
      encoded = '<?php eval("?>".base64_decode("' + base64  + '")."<?\"); ?>'
      encoded

    getEncodedJS: (string) ->
      switch @options.js_encoder
        when 'jjencode' then @getJJEncoded(string)
        else @getJJEncoded(string)

    getJJEncoded: (string) ->
      jjencode = new JJEncode()
      jjencoded = jjencode.jjencode(@options.js_variable, string)
      jjencoded

    isValid: (extname) ->
      _.contains(['.js', '.php'], extname)

  # ----------
  # RETURN
  # ----------
  Hazy


