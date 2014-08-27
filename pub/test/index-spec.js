var Counter, should, __reset, _chai, _counter;

if (typeof require !== "undefined" && require !== null) {
  console.log('require exists and is a function.  Going to assume we are in a Node.js environment.');
  _chai = require('chai');
  Counter = require('../src/counter')["class"];
  _counter = require('../..');
  should = _chai.should();
  __reset = require('../src/extensions')._testable.reset;
} else {
  _counter = this.chai_counter;
  should = this.chai.should();
  __reset = _counter._testable.reset;
}

describe('chai-counter', function() {
  beforeEach(function() {
    return __reset();
  });
  describe('#expect()', function() {
    it('should throw Error if passed null', function() {
      var testFunc;
      testFunc = function() {
        return _counter.expect(null);
      };
      return testFunc.should["throw"](Error, 'expectedAsserts needs to be of type \'number\'');
    });
    it('should throw Error if passed undefined', function() {
      return _counter.expect.should["throw"](Error, 'expectedAsserts needs to be of type \'number\'');
    });
    it('should throw Error if passed negative number', function() {
      var testFunc;
      testFunc = function() {
        return _counter.expect(-1337);
      };
      return testFunc.should["throw"](Error, 'expectedAsserts needs to be > 0');
    });
    it('should throw Error if passed zero', function() {
      var testFunc;
      testFunc = function() {
        return _counter.expect(0);
      };
      return testFunc.should["throw"](Error, 'expectedAsserts needs to be > 0');
    });
    it('should not throw Error if passed a positive number', function() {
      var testFunc;
      testFunc = function() {
        return _counter.expect(5);
      };
      return testFunc.should.not["throw"](Error);
    });
    return it('returns a new Counter instance', function() {
      return _counter.expect(5).should.be["instanceof"](Counter);
    });
  });
  describe('#assert()', function() {
    it('should throw Error if called before #expect()', function() {
      return _counter.assert.should["throw"](Error, 'You need to set the expected number of assertions first--use #expect()');
    });
    return it('should throw Error if called twice', function() {
      _counter.expect(1);
      "abc".should.cc;
      _counter.assert();
      return _counter.assert.should["throw"](Error, 'You need to set the expected number of assertions first--use #expect()');
    });
  });
  return describe('chai #cc', function() {
    it('should count asserts properly', function() {
      _counter.expect(1);
      _counter.assert.should["throw"](Error);
      'abc'.should.equal('abc').cc;
      return _counter.assert.should.not["throw"](Error);
    });
    it('should be callable as a method', function() {
      var testFunc;
      testFunc = function() {
        _counter.expect(1);
        return 'abc'.should.be.a('string').cc();
      };
      return testFunc.should.not["throw"](Error);
    });
    return it('should be callable as a property', function() {
      var testFunc;
      testFunc = function() {
        _counter.expect(1);
        return 'abc'.should.be.a('string').cc;
      };
      testFunc.should.not["throw"](Error);
      testFunc = function() {
        _counter.expect(1);
        return 'abc'.should.cc.be.a('string');
      };
      return testFunc.should.not["throw"](Error);
    });
  });
});
