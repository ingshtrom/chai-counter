if require?
  _chai = require 'chai'
  Counter = require('./counter').class
  _expect = _chai.expect
else
  _expect = this['chai'].expect

_counter = null

_addAssertion = () =>
  _expect(_counter).to.not.be.equal null,
    "You need to set the expected number of assertions first--use #expect()"
  _counter.add()

# #extensions
# setup the extensi
exports.plugin = (_chai, utils) =>
  Assertion = _chai.Assertion
  Assertion.addChainableMethod 'cc', _addAssertion, _addAssertion

# #expect()
# set the number of expected assertions
# param (number): the number of expected asserts
exports.expect = (expectedAsserts) =>
  _expect(expectedAsserts).to.be.a('number',
    'expectedAsserts needs to be of type \'number\'')
  _expect(expectedAsserts).to.be.above(0, 'expectedAsserts needs to be > 0')
  _counter = new Counter expectedAsserts

# #assert()
# make sure the expected number of assertions were made
# will reset the counter object, so only call this once per test!
exports.assert = () =>
  _expect(_counter).to.not.be.equal null,
    "You need to set the expected number of assertions first--use #expect()"
  _counter.assert()
  _counter = null # need to reset _counter for the next time it is used

# _testable interface for testing purposes ONLY!
exports._testable =

  # we need to be able to reset the _counter object
  reset: () => _counter = null
