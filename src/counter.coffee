exports = exports ? this

if typeof require == 'function'
  chai = require 'chai'
  assert = chai.assert
else
  assert = this['chai'].assert

class Counter
  constructor: (@expected) ->
    @actual = 0
  add: () =>
    @actual++
  assert: () =>
    assert.equal @actual,
      @expected,
      "Expected #{@expected} assertions, counted #{@actual}."

exports.class = Counter
