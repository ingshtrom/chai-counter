var Counter, _assert, _chai,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

if (typeof require !== "undefined" && require !== null) {
  _chai = require('chai');
  _assert = _chai.assert;
} else {
  _chai = this['chai'];
  _assert = _chai.assert;
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
    return _assert.equal(this.actual, this.expected, "Expected " + this.expected + " assertions, counted " + this.actual + ".");
  };

  return Counter;

})();

exports["class"] = Counter;
