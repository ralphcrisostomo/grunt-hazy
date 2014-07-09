'use strict' 

grunt = require('grunt')

###
  ======== A Handy Little Nodeunit Reference ========
  https:#github.com/caolan/nodeunit

  Test methods:
    test.expect(numAssertions)
    test.done()
  Test assertions:
    test.ok(value, [message])
    test.equal(actual, expected, [message])
    test.notEqual(actual, expected, [message])
    test.deepEqual(actual, expected, [message])
    test.notDeepEqual(actual, expected, [message])
    test.strictEqual(actual, expected, [message])
    test.notStrictEqual(actual, expected, [message])
    test.throws(block, [error], [message])
    test.doesNotThrow(block, [error], [message])
    test.ifError(value)
###

exports.hazy = 
  setUp: (done) ->
    # setup here if necessary
    done() 
  
  default_options: (test) ->
    test.expect(1) 

    actual = grunt.file.read('tmp/default_options.php')
    expected = grunt.file.read('test/expected/default_options.php')
    test.equal(actual, expected, 'should describe what the default behavior is.') 

    test.done()

  php: (test) ->
    test.expect(1) 

    actual = grunt.file.read('tmp/sample.php')
    expected = grunt.file.read('test/expected/sample.php')
    test.equal(actual, expected, 'should describe what the custom option(s) behavior is.') 

    test.done()

  js: (test) ->
    test.expect(1)

    actual = grunt.file.read('tmp/sample.js')
    expected = grunt.file.read('test/expected/sample.js')
    test.equal(actual, expected, 'should describe what the custom option(s) behavior is.')

    test.done()
