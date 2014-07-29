'use strict'

module.exports = (grunt) ->

    configuration =
        pkg: grunt.file.readJSON 'package.json'
        bgShell:
            latest:
                cmd: 'touch this-is-latest.txt'
            public:
                cmd: 'touch this-is-public.txt'

    grunt.initConfig configuration
    
    grunt.loadNpmTasks 'grunt-bg-shell'

    grunt.registerTask 'waitress-public', ['bgShell:public']
    grunt.registerTask 'waitress-latest', ['bgShell:latest']
    
    grunt.registerTask 'default', ['waitress-public']