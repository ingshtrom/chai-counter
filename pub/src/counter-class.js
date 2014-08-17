(function() {
  var Counter, assert,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  assert = require('assert');

  Counter = (function() {
    function Counter(expected) {
      this.expected = expected;
      this.assert = __bind(this.assert, this);
      this.add = __bind(this.add, this);
      this.actual = 0;
    }

    Counter.prototype.add = function() {
      return this.actual++;
    };

    Counter.prototype.assert = function() {
      return assert.equal(this.actual, this.expected, "Expected " + this.expected + " assertions, counted only " + this.actual + ".");
    };

    return Counter;

  })();

  module.exports = Counter;

}).call(this);
