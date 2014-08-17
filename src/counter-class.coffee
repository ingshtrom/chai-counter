assert = require 'assert'

class Counter
  constructor: (@expected) =>
    @actual = 0
  add: () =>
    @actual++
  assert: () =>
    console.log "actual: #{@actual}"
    console.log "expected: #{@expected}"
    assert.equal @actual, @expected, "Expected #{@expected} assertions, counted only #{@actual}."

module.exports = Counter
