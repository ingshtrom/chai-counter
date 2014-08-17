(function() {
  var Counter, chai, should;

  chai = require('chai');

  should = chai.should();

  Counter = require('../src/counter-class');

  describe('Counter', function() {
    describe('contructor', function() {
      return it('should set defaults correctly', function() {
        var _counter;
        _counter = new Counter(3);
        _counter.expected.should.be.a.Number;
        _counter.expected.should.equal(3);
        _counter.actual.should.be.a.Number;
        return _counter.actual.should.equal(0);
      });
    });
    describe('#add()', function() {
      return it('should add correctly', function() {
        var _counter;
        _counter = new Counter(3);
        _counter.add();
        _counter.add();
        _counter.actual.should.be.a.Number;
        return _counter.actual.should.equal(2);
      });
    });
    return describe('#assert()', function() {
      it('should not throw when @actual == @expected', function() {
        var _counter;
        _counter = new Counter(1);
        _counter.add();
        return _counter.assert.should.not["throw"];
      });
      return it('should throw when @actual != @expected', function() {
        var _counter;
        _counter = new Counter(5);
        _counter.add();
        return _counter.assert.should["throw"](Error);
      });
    });
  });

}).call(this);
