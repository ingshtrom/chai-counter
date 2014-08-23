if typeof require == 'function'
  chai = require 'chai'
  Counter = require './counter'

# expect 'chai' to be loaded
# expect 'Counter' to be loaded
expect = chai.expect
_counter = null

_addAssertion = () =>
  expect(_counter).to.not.be.equal null,
    "You need to set the expected number of assertions first--use #expect()"
  _counter.add()

# #extensions
# setup the extensi
module.exports['chai-counter-plugin'] = (_chai, utils) =>
  Assertion = chai.Assertion
  Assertion.addChainableMethod 'cc', _addAssertion, _addAssertion

# #expect()
# set the number of expected assertions
# param (number): the number of expected asserts
module.exports.expect = (expectedAsserts) =>
  expect(expectedAsserts).to.be.a('number',
    'expectedAsserts needs to be of type \'number\'')
  expect(expectedAsserts).to.be.above(0, 'expectedAsserts needs to be > 0')
  _counter = new Counter expectedAsserts

# #assert()
# make sure the expected number of assertions were made
# will reset the counter object, so only call this once per test!
module.exports.assert = () =>
  expect(_counter).to.not.be.equal null,
    "You need to set the expected number of assertions first--use #expect()"
  _counter.assert()
  _counter = null # need to reset _counter for the next time it is used

# _testable interface for testing purposes ONLY!
module.exports._testable =

  # we need to be able to reset the _counter object
  reset: () => _counter = null
