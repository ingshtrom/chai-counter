[![NPM](https://nodei.co/npm/chai-counter.png?downloads=true&downloadRank=true&stars=true)](https://nodei.co/npm/chai-counter/)

[![Build Status](https://travis-ci.org/ingshtrom/chai-counter.svg?branch=master)](https://travis-ci.org/ingshtrom/chai-counter)
[![Coverage Status](https://img.shields.io/coveralls/ingshtrom/chai-counter.svg)](https://coveralls.io/r/ingshtrom/chai-counter?branch=master)
[![Sauce Test Status](https://saucelabs.com/buildstatus/ingshtrom)](https://saucelabs.com/u/ingshtrom)

[![Dependency Manager](https://david-dm.org/ingshtrom/chai-counter.svg)](https://david-dm.org/ingshtrom/chai-counter)
[![devDependency Manager](https://david-dm.org/ingshtrom/chai-counter/dev-status.svg)](https://david-dm.org/ingshtrom/chai-counter#info=devDependencies)

[![Built with Grunt](https://cdn.gruntjs.com/builtwith.png)](http://gruntjs.com/)

Chai-counter
============

Chai.js plugin that allows for counting assertions.  Based off of https://github.com/chaijs/chai/issues/94

Why do I want it?
-----------------
Because after a while you will have hundreds of tests that will only continue to get more complex. Once complexity sets in, testing becomes less effective. To combat complexity and ensure that you are _actually_ testing what you think you are testing, you can count the number of assertions!  Counting the assertions will give you peace-of-mind knowing that all of your asserts were hit. Now, you just have to make sure you made enough asserts. :)

How do I get it?
----------------
I got you hooked, right!? Good thing it takes next to nothing to get! It is on [NPM](https://www.npmjs.org/), so you can add it to your `devDependencies` in `package.json` or just run `npm install chai-counter --save-dev`. Easy-peasy-lemon-squeezy!

How do I use it?
----------------
I like to do my testing with [Mocha](http://visionmedia.github.io/mocha/) and [Chai.js](http://chaijs.com/), with the `should` and the [BDD interface](http://visionmedia.github.io/mocha/#interfaces).  You can find some complete examples in the `test/` directory.

First, you will want to include the `chai-counter` library _after_ including the `chai` module.

```coffeescript
# CoffeeScript is awesome!
chai = require 'chai'
counter = require 'chai-counter'
```

Alternatively, **if you are writing for the browser**, you will load the scripts in this fashion.

```html
<script type="text/javascript" src="/chai.js"></script>
<script type="text/javascript" src="/chai-counter.js"></script>
<script type="text/javascript">
  counter = window["chai-counter"]
  chai.use(counter["chai-counter-plug"])
</script>
```

Then, tell `chai-counter` how many assertions you expect.

```coffeescript
counter.expect(4)
```

Next, you can add some assertions.

```coffeescript
'abc'.should.be.a('string').cc
'abc'.should.be.a('string').cc()
'abc'.should.be.a('string').cc.and.should.equal('abc').cc
```

Finally, make sure you assert that all of your assertions were checked.

```coffeescript
counter.assert()
```

__NOTE__ After loading, the `counter.expect(4)` and `counter.assert()` calls will be exactly the same for both Node.js and the browser.
