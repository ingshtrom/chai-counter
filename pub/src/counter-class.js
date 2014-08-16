(function() {
  var Counter;

  Counter = (function() {
    function Counter(expected) {
      this.expected = expected;
      this.actual = 0;
    }

    Counter.prototype.add = function() {
      return this.actual++;
    };

    return Counter;

  })();

  module.exports = Counter;

}).call(this);
