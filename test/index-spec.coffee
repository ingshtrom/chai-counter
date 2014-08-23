if typeof require == 'function'
  console.log 'require exists and is a function.  Going to assume we are in a Node.js environment.'
  chai = require 'chai'
  Counter = require '../src/counter'
  ext = require '../src/extensions'
  counter = require '../src/index' # we want to load it like a user would

should = chai.should()

describe 'chai-counter', () ->

  # reset the counter library every test
  beforeEach () -> ext._testable.reset()

  describe '#expect()', () ->

    it 'should throw Error if passed null', () ->
      testFunc = () ->
        counter.expect null
      testFunc.should.throw Error,
        'expectedAsserts needs to be of type \'number\''

    it 'should throw Error if passed undefined', () ->
      # same as passing no arguments
      counter.expect.should.throw Error,
        'expectedAsserts needs to be of type \'number\''

    it 'should throw Error if passed negative number', () ->
      testFunc = () ->
        counter.expect -1337
      testFunc.should.throw Error, 'expectedAsserts needs to be > 0'

    it 'should throw Error if passed zero', () ->
      testFunc = () ->
        counter.expect 0
      testFunc.should.throw Error, 'expectedAsserts needs to be > 0'

    it 'should not throw Error if passed a positive number', () ->
      testFunc = () ->
        counter.expect 5
      testFunc.should.not.throw Error

    it 'returns a new Counter instance', () ->
      # this is the best we can do to check that a new
      # counter instance is created
      counter.expect(5).should.be.instanceof(Counter)

  describe '#assert()', () ->

    it 'should throw Error if called before #expect()', () ->
      counter.assert.should.throw Error,
        'You need to set the expected number of assertions first--use #expect()'

    it 'should throw Error if called twice', () ->
      counter.expect(1)
      "abc".should.cc
      counter.assert()
      counter.assert.should.throw Error,
        'You need to set the expected number of assertions first--use #expect()'

  describe 'chai #cc', () ->

    it 'should count asserts properly', () ->
      counter.expect(1)
      counter.assert.should.throw Error
      'abc'.should.equal('abc').cc
      counter.assert.should.not.throw Error

    it 'should be callable as a method', () ->
      # make sure it works as a method at the end
      testFunc = () ->
        counter.expect(1)
        'abc'.should.be.a('string').cc()
      testFunc.should.not.throw Error

    it 'should be callable as a property', () ->
      testFunc = () ->
        counter.expect(1)
        'abc'.should.be.a('string').cc
      testFunc.should.not.throw Error

      testFunc = () ->
        counter.expect(1)
        'abc'.should.cc.be.a('string')
      testFunc.should.not.throw Error
