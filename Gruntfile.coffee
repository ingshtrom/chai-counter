module.exports = (grunt) ->
  # just testing what Chai.js uses: https://github.com/chaijs/chai
  # added a few extras
  browsers = [
    {
      browserName: 'firefox'
      version: '22'
      platform: 'Windows 7'
    },
    {
      browserName: 'firefox'
      platform: 'Windows 8.1'
    },
    {
      browserName: 'chrome'
      platform: 'linux'
    },
    {
      browserName: 'chrome'
      platform: 'Windows 8.1'
    },
    {
      browserName: 'internet explorer'
      version: '10'
      platform: 'Windows 8'
    },
    {
      browserName: 'safari'
      version: '6'
      platform: 'OS X 10.8'
    },
    {
      browserName: 'safari'
      version: '7'
      platform: 'OS X 10.9'
    }
  ]

  sauceSerializedTestConfig =
    public: "public"
    tags:  [
      "TRAVIS_JOB_ID: " + process.env.TRAVIS_JOB_ID,
      "TRAVIS_JOB_NUMBER: " + process.env.TRAVIS_JOB_NUMBER,
      "TRAVIS_BUILD_ID: " + process.env.TRAVIS_BUILD_ID,
      "TRAVIS_BUILD_NUMBER: " + process.env.TRAVIS_BUILD_NUMBER,
      "TRAVIS_REPO_SLUG: " + process.env.TRAVIS_REPO_SLUG
    ]

  grunt.initConfig
    globalConfig:
      pub: 'pub'
      src: 'src'
      test: 'test'
      lib: 'pub/lib'

    pkg: grunt.file.readJSON 'package.json'
    'clean':
      all: ['<%= globalConfig.pub %>/**/*']
      src: ['<%= globalConfig.pub %>/src/**/*']
      test: ['<%= globalConfig.pub %>/test/**/*']
    'coffeelint':
      options:
        max_line_length:
          level: 'ignore'
      src: [
        '<%= globalConfig.src %>/**/*.coffee',
        '!<%= globalConfig.src %>/**/*-spec.coffee'
      ]
      test: ['<%= globalConfig.test %>/**/*-spec.coffee']
    'coffee':
      options:
        bare: true
      src:
        files: [
          {
            expand: true
            flatten: true
            cwd: '<%= globalConfig.src %>'
            src: ['*.coffee', '!*-spec.coffee']
            dest: '<%= globalConfig.pub %>/src'
            ext: '.js'
          }
        ]
      test:
        files: [
          {
            expand: true
            flatten: true
            cwd: '<%= globalConfig.test %>'
            src: ['*-spec.coffee']
            dest: '<%= globalConfig.pub %>/test'
            ext: '.js'
          }
        ]
      'browser-src':
        files:
          '<%= globalConfig.pub %>/src/chai-counter.js': [
            '<%= globalConfig.src %>/counter.coffee',
            '<%= globalConfig.src %>/extensions.coffee'
          ]
    'bower':
      dist:
        dest: '<%= globalConfig.pub %>/lib'
        js_dest: '<%= globalConfig.pub %>/lib/js'
        css_dest: '<%= globalConfig.pub %>/lib/css'
    'copy':
      dist:
        files:
          '<%= globalConfig.pub %>/test/browser/index.html': '<%= globalConfig.test %>/browser/index.html'
    'concat':
      'browser-src-chai-counter':
        options:
          banner: '(function(exports){'
          footer: "})(window['chai_counter']={});" + "\r\n\r\n" + "chai.use(this.chai_counter.plugin);"
        files:
          '<%= globalConfig.pub %>/src/chai-counter.js': '<%= globalConfig.pub %>/src/chai-counter.js'
      'browser-src-counter':
        options:
          banner: '(function(exports){'
          footer: "})(window['Counter']={});"
        files:
          '<%= globalConfig.pub %>/test/browser/counter.js': '<%= globalConfig.pub %>/src/counter.js'
      'browser-src-extensions':
        options:
          banner: '(function(exports){'
          footer: "})(window['extensions']={});"
        files:
          '<%= globalConfig.pub %>/test/browser/extensions.js': '<%= globalConfig.pub %>/src/extensions.js'
    'connect':
      server:
        options:
          base: ""
          port: 9999
    'saucelabs-mocha':
      all:
        options:
          urls: ["http://127.0.0.1:9999/pub/test/browser/index.html"]
          tunnelTimeout: 10
          build: process.env.TRAVIS_BUILD_NUMBER
          browsers: browsers
          testname: "chai-counter unit tests"
          sauceConfig: sauceSerializedTestConfig
    'watch': {}

  # loading dependencies
  devDeps = grunt.file.readJSON("package.json").devDependencies
  for key, value of devDeps
    if key != "grunt" && key.indexOf("grunt") == 0
      grunt.loadNpmTasks key

  concatAndWrapForBrowser = () ->
    grunt.task.run [
      'coffee:browser-src',
      'concat:browser-src-chai-counter',
      'concat:browser-src-counter',
      'concat:browser-src-extensions'
    ]

  grunt.registerTask 'default', () ->
    grunt.task.run ['clean:all', 'coffeelint', 'coffee', 'bower', 'copy']
    concatAndWrapForBrowser()

  grunt.registerTask 'test:setup', () ->
    grunt.task.run [
      'clean:all',
      'coffeelint',
      'coffee',
      'bower',
      'copy',
      'concat'
    ]

  grunt.registerTask 'test:browser:sauce', () ->
    if process.env.TRAVIS && process.env.CI && process.env.TRAVIS_NODE_VERSION.indexOf("0.11") < 0
      return
    grunt.task.run [
      'connect',
      'saucelabs-mocha'
    ]

  grunt.registerTask 'test:browser:local', () ->
    testUrls = grunt.config.get('saucelabs-mocha.all.options.urls').join(', ')
    grunt.log.writeln "open your browser to #{testUrls}"
    grunt.task.run [
      'test:setup',
      'connect',
      'watch'
    ]
