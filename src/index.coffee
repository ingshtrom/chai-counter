if require?
  _chai = require 'chai'
  _extensions = require './extensions'
else
  _extensions = extensions
  _chai = chai

exports.expect = (expectedAsserts) ->
  _extensions.expect expectedAsserts

exports.assert = () ->
  _extensions.assert()

# now register our extensions with Chai.js!
_chai.use(_extensions.plugin)
