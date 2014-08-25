if require?
  console.log 'require exists and is a function.  Going to assume we are in a Node.js environment.'
  _chai = require 'chai'
  Counter = require('../src/counter').class
  _counter = require '../..' # we want to load it like a user would
  should = _chai.should()
  __reset = require('../src/extensions')._testable.reset
else
  _counter = this.chai_counter
  should = this.chai.should()
  __reset = _counter._testable.reset

describe 'chai-counter', () ->

  # reset the _counter library every test
  beforeEach () ->
    __reset()

  describe '#expect()', () ->

    it 'should throw Error if passed null', () ->
      testFunc = () ->
        _counter.expect null
      testFunc.should.throw Error,
        'expectedAsserts needs to be of type \'number\''

    it 'should throw Error if passed undefined', () ->
      # same as passing no arguments
      _counter.expect.should.throw Error,
        'expectedAsserts needs to be of type \'number\''

    it 'should throw Error if passed negative number', () ->
      testFunc = () ->
        _counter.expect -1337
      testFunc.should.throw Error, 'expectedAsserts needs to be > 0'

    it 'should throw Error if passed zero', () ->
      testFunc = () ->
        _counter.expect 0
      testFunc.should.throw Error, 'expectedAsserts needs to be > 0'

    it 'should not throw Error if passed a positive number', () ->
      testFunc = () ->
        _counter.expect 5
      testFunc.should.not.throw Error

    it 'returns a new Counter instance', () ->
      # this is the best we can do to check that a new
      # _counter instance is created
      _counter.expect(5).should.be.instanceof(Counter)

  describe '#assert()', () ->

    it 'should throw Error if called before #expect()', () ->
      _counter.assert.should.throw Error,
        'You need to set the expected number of assertions first--use #expect()'

    it 'should throw Error if called twice', () ->
      _counter.expect(1)
      "abc".should.cc
      _counter.assert()
      _counter.assert.should.throw Error,
        'You need to set the expected number of assertions first--use #expect()'

  describe 'chai #cc', () ->

    it 'should count asserts properly', () ->
      _counter.expect(1)
      _counter.assert.should.throw Error
      'abc'.should.equal('abc').cc
      _counter.assert.should.not.throw Error

    it 'should be callable as a method', () ->
      # make sure it works as a method at the end
      testFunc = () ->
        _counter.expect(1)
        'abc'.should.be.a('string').cc()
      testFunc.should.not.throw Error

    it 'should be callable as a property', () ->
      testFunc = () ->
        _counter.expect(1)
        'abc'.should.be.a('string').cc
      testFunc.should.not.throw Error

      testFunc = () ->
        _counter.expect(1)
        'abc'.should.cc.be.a('string')
      testFunc.should.not.throw Error
