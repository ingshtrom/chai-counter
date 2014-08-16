assert = require 'assert'
Counter = require './counter-class'

module.exports.expect = (numOfAsserts) ->
  _counter = new Counter numOfAsserts

module.exports.assert = () ->
  assert.equal _counter.actual,
    _counter.expected,
    "Expected #{_counter.expected} assertions, but only counted #{_counter.actual}"

module.exports.extensions = (_chai, utils) ->
  Assertion = chai.Assertion
  Assertion.addProperty ''
