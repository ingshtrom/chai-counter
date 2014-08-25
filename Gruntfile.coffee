module.exports = (grunt) ->
  browsers = [
    {
      browserName: 'firefox'
      platform: 'XP'
    },
    {
      browserName: 'googlechrome'
      platform: 'XP'
    },
    {
      browserName: 'googlechrome'
      platform: 'linux'
    },
    {
      browserName: 'internet explorer'
      version: '10'
      platform: 'WIN8'
    }
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
        sourceMap: true
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
          urls: ["http://127.0.0.1:9999/pub/test/browser/index.html"],
          tunnelTimeout: 5,
          build: process.env.TRAVIS_JOB_ID,
          concurrency: 2,
          browsers: browsers,
          testname: "chai-counter browser tests",
          tags: ["master"]
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
    grunt.file.mkdir 'logs'

  grunt.registerTask 'test', () ->
    grunt.util.spawn {
      cmd: 'npm'
      grunt: false
      args: ['test']
    }, (err, result, code) ->
      if error?
        grunt.log.errorln 'error running tests'
        grunt.log.errorln "stderr: #{result.stderr}"
        return
      grunt.log.writeln "stdout: #{result.stdout}"

  grunt.registerTask 'test:browser:sauce', () ->
    grunt.task.run [
      'clean:all',
      'coffeelint',
      'coffee',
      'bower',
      'copy',
      'concat',
      'connect',
      'saucelabs-mocha'
    ]

  grunt.registerTask 'test:browser:local', () ->
    grunt.task.run [
      'clean:all',
      'coffeelint',
      'coffee',
      'bower',
      'copy',
      'concat'
    ]
    testUrls = grunt.config.get('saucelabs-mocha.all.options.urls').join(', ')
    grunt.log.writeln "open your browser to #{testUrls}"
    grunt.task.run ['connect', 'watch']
