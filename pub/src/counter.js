(function() {
  var Counter, assert, chai,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  if (typeof require === 'function') {
    chai = require('chai');
    assert = chai.assert;
  } else {
    assert = this['chai'].assert;
  }

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
      return assert.equal(this.actual, this.expected, "Expected " + this.expected + " assertions, counted " + this.actual + ".");
    };

    return Counter;

  })();

  exports["class"] = Counter;

}).call(this);
