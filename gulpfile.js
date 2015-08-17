'use strict';

var gulp = require('gulp');
var del = require('del');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var rename = require('gulp-rename');

var paths = {
  dest: 'assets/scripts/',
  scripts: [
    'bower_components/html5shiv/dist/html5shiv.js',
    'bower_components/json2/json2.js'
  ]
};

gulp.task('clean', function(cb) {
  // Ensure the files are deleted before calling next task
  del(paths.dest + 'ie.js', cb);
});

gulp.task('build', ['clean'], function() {
  return gulp
    .src(paths.scripts)
    .pipe(concat('ie.js'))
    .pipe(gulp.dest(paths.dest));
});

gulp.task('minify-scripts', ['build'], function() {
  return gulp
    .src(paths.dest + 'ie.js')
    .pipe(uglify({ mangle: false, compress: false }))
    .pipe(rename({ suffix: '.min' }))
    .pipe(gulp.dest(paths.dest));
});

gulp.task('default', ['build', 'minify-scripts']);
