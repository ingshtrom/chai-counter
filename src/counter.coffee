if require?
  _chai = require 'chai'
  _assert = _chai.assert
else
  _chai = this['chai']
  _assert = _chai.assert

class Counter
  constructor: (@expected) ->
    @actual = 0
  add: () =>
    @actual++
  assert: () =>
    _assert.equal @actual,
      @expected,
      "Expected #{@expected} assertions, counted #{@actual}."

exports.class = Counter
