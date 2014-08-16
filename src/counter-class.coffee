class Counter
  constructor: (@expected) ->
    @actual = 0
  add: () ->
    @actual++

module.exports = Counter
