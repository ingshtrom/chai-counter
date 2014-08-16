chai = require 'chai'
should = chai.should()
counter = require '../src/counter'

chai.use(counter)

describe 'chai-counter src/', () ->
  it 'should be chainable', () ->
  it 'should count asserts properly', () ->
