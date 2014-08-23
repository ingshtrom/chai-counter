if typeof require == 'function'
  chai = require 'chai'
  extensions = require './extensions'

# expect 'chai' to be loaded
# expect 'extensions' to be loaded

module.exports.expect = (expectedAsserts) ->
  extensions.expect expectedAsserts

module.exports.assert = () ->
  extensions.assert()

# now register our extensions with Chai.js!
chai.use(extensions['chai-counter-plugin'])
