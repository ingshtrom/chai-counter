(function() {
  var chai, counter, should;

  chai = require('chai');

  should = chai.should();

  counter = require('../src/counter');

  chai.use(counter);

  describe('chai-counter src/', function() {
    it('should be chainable', function() {});
    return it('should count asserts properly', function() {});
  });

}).call(this);
