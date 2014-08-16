(function() {
  var Counter, assert;

  assert = require('assert');

  Counter = require('./counter-class');

  module.exports.expect = function(numOfAsserts) {
    var _counter;
    return _counter = new Counter(numOfAsserts);
  };

  module.exports.assert = function() {
    return assert.equal(_counter.actual, _counter.expected, "Expected " + _counter.expected + " assertions, but only counted " + _counter.actual);
  };

  module.exports.extensions = function(_chai, utils) {
    var Assertion;
    Assertion = chai.Assertion;
    return Assertion.addProperty('');
  };

}).call(this);
