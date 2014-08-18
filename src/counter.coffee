assert = require 'assert'

class Counter
  constructor: (@expected) ->
    @actual = 0
  add: () =>
    @actual++
  assert: () =>
    assert.equal @actual,
      @expected,
      "Expected #{@expected} assertions, counted #{@actual}."

module.exports = Counter
