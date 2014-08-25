if require?
  console.log 'require exists and is a function.  Going to assume we are in a Node.js environment.'
  _chai = require 'chai'
  Counter = require('../src/counter').class
  should = _chai.should()
else
  should = this['chai'].should()

describe 'Counter', () ->
  describe 'contructor', () ->
    it 'should set defaults correctly', () ->
      _counter = new Counter 3
      _counter.expected.should.be.a.Number
      _counter.expected.should.equal 3
      _counter.actual.should.be.a.Number
      _counter.actual.should.equal 0
  describe '#add()', () ->
    it 'should add correctly', () ->
      _counter = new Counter 3
      _counter.add()
      _counter.add()
      _counter.actual.should.be.a.Number
      _counter.actual.should.equal 2
  describe '#assert()', () ->
    it 'should not throw when @actual == @expected', () ->
      _counter = new Counter 1
      _counter.add()
      _counter.assert.should.not.throw
    it 'should throw when @actual != @expected', () ->
      _counter = new Counter 5
      _counter.add()
      _counter.assert.should.throw Error
