var Counter, _addAssertion, _chai, _counter, _expect;

if (typeof require !== "undefined" && require !== null) {
  _chai = require('chai');
  Counter = require('./counter')["class"];
  _expect = _chai.expect;
} else {
  _expect = this['chai'].expect;
}

_counter = null;

_addAssertion = (function(_this) {
  return function() {
    _expect(_counter).to.not.be.equal(null, "You need to set the expected number of assertions first--use #expect()");
    return _counter.add();
  };
})(this);

exports.plugin = (function(_this) {
  return function(_chai, utils) {
    var Assertion;
    Assertion = _chai.Assertion;
    return Assertion.addChainableMethod('cc', _addAssertion, _addAssertion);
  };
})(this);

exports.expect = (function(_this) {
  return function(expectedAsserts) {
    _expect(expectedAsserts).to.be.a('number', 'expectedAsserts needs to be of type \'number\'');
    _expect(expectedAsserts).to.be.above(0, 'expectedAsserts needs to be > 0');
    return _counter = new Counter(expectedAsserts);
  };
})(this);

exports.assert = (function(_this) {
  return function() {
    _expect(_counter).to.not.be.equal(null, "You need to set the expected number of assertions first--use #expect()");
    _counter.assert();
    return _counter = null;
  };
})(this);

exports._testable = {
  reset: (function(_this) {
    return function() {
      return _counter = null;
    };
  })(this)
};
