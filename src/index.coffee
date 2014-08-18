chai = require 'chai'
should = chai.should()
Counter = require './counter'
extensions = require './extensions'

module.exports.expect = (expectedAsserts) ->
  extensions.expect expectedAsserts

module.exports.assert = () ->
  extensions.assert()

# now register our extensions with Chai.js!
chai.use(extensions.setupHelper)
