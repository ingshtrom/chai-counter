var _chai, _extensions;

if (typeof require !== "undefined" && require !== null) {
  _chai = require('chai');
  _extensions = require('./extensions');
} else {
  _extensions = extensions;
  _chai = chai;
}

exports.expect = function(expectedAsserts) {
  return _extensions.expect(expectedAsserts);
};

exports.assert = function() {
  return _extensions.assert();
};

_chai.use(_extensions.plugin);
