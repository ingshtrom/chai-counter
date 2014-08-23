module.exports = (grunt) ->
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
          footer: "})(typeof exports === 'undefined'? window['chai-counter']={}: exports);"
        files:
          '<%= globalConfig.pub %>/src/chai-counter.js': '<%= globalConfig.pub %>/src/chai-counter.js'
      'browser-src-counter':
        options:
          banner: '(function(exports){'
          footer: "})(typeof exports === 'undefined'? window['Counter']={}: exports);"
        files:
          '<%= globalConfig.pub %>/test/browser/counter.js': '<%= globalConfig.pub %>/src/counter.js'

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-bower'

  concatAndWrapForBrowser = () ->
    grunt.task.run [
      'coffee:browser-src',
      'concat:browser-src-chai-counter',
      'concat:browser-src-counter'
    ]

  grunt.registerTask 'default', () ->
    grunt.task.run ['clean:all', 'coffeelint', 'coffee', 'bower', 'copy']
    concatAndWrapForBrowser()
    grunt.file.mkdir 'logs'

  grunt.registerTask 'test', () ->
    grunt.task.run ['dist', 'coffeelint:test', 'coffee:test']
