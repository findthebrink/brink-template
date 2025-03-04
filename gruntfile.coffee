module.exports = (grunt)->
	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json')
		coffee:
			compile:
				options:
					banner: '/* <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
				files:
					'./dist/lib/www.js': './dev/coffee/bin/www.coffee'
					'./dist/webApp.js':'./dev/coffee/bin/webApp.coffee'
					'./dist/routes.js': './dev/coffee/bin/routes.coffee'
					'./dist/public/js/scripts.js': './dev/coffee/lib/ui.coffee'
		copy:
			views:
				src: '**'
				dest: './dist/views/'
				expand: true
				cwd: './dev/jade/'
			public:
				src: '**'
				dest: './dist/public/assets'
				expand: true
				cwd: './dev/assets/'
			backgrounds:
				src: '**'
				dest: './dist/public/css/backgrounds/'
				expand: true
				cwd: './dev/sass/theme/backgrounds/'
			styleguide:
				src: '**'
				dest: './dev/sass/kss/styleguide-template/public/'
				expand: true
				cwd: './dist/public/'
		sass:
			dist:
				files:
					'./dist/public/css/index.css': './dev/sass/index.sass'
					'./dev/sass/kss/styleguide-template/public/index.css': './dev/sass/index.sass'
		watch:
			files: ['./dev/coffee/**','./dev/sass/**','./dev/jade/**','./dev/public/**','./dev/assets/**','./dev/kss/**','./gruntfile.coffee','!./dev/sass/kss/styleguide-template/public/**']
			tasks: ['coffee:compile', 'sass:dist', 'copy', 'wiredep']
		jshint:
			all: ['./public/js/*.js']
		kss:
			options:
				template: './dev/sass/kss/styleguide-template'
			dist:
				files: './styleguide/': './dev/sass/'
		wiredep:
			task:
				src: ['dist/views/includes/head.jade', 'dist/views/includes/scripts.jade']
				ignorePath: '../../public'
		})
	
	grunt.loadNpmTasks('grunt-contrib-jshint')
	grunt.loadNpmTasks('grunt-contrib-copy')
	grunt.loadNpmTasks('grunt-contrib-sass')
	grunt.loadNpmTasks('grunt-contrib-coffee')
	grunt.loadNpmTasks('grunt-contrib-watch')
	grunt.loadNpmTasks('grunt-kss')
	grunt.loadNpmTasks('grunt-wiredep')

	grunt.registerTask('default', ['coffee', 'sass:dist', 'copy', 'kss', 'wiredep'])