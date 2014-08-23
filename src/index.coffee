exports = exports ? this

if typeof require == 'function'
  tmpChai = require 'chai'
  tmpExtensions = require './extensions'
else
  tmpExtensions = extensions
  tmpChai = chai

chai = tmpChai
extensions = tmpExtensions

module.exports.expect = (expectedAsserts) ->
  extensions.expect expectedAsserts

module.exports.assert = () ->
  extensions.assert()

# now register our extensions with Chai.js!
chai.use(extensions['chai-counter-plugin'])
