var bowerMeta = require('./bower.json');
var util = require('util');

var BOWER_DIR = 'bower_components';

function prefixPaths(pathsArray, moduleName, isRoot) {
  moduleName = (moduleName || '');
  return pathsArray.map(function(path) {
    var bowerDir = isRoot ? '' : util.format('/%s/', BOWER_DIR);
    return util.format('node_modules/%s%s%s/', moduleName, bowerDir, path);
  });
}

module.exports = {
  getImportPaths: function() {
    try {
      var importPaths = prefixPaths(bowerMeta.importPaths, '', true) || [];
      var bowerDeps = bowerMeta.dependencies || [];

      Object.keys(bowerDeps).map(function(dep) {
        var paths = [];
        try {
          paths = require(util.format('./%s/%s/bower.json', BOWER_DIR, dep)).importPaths || [];
        } catch(e) {}

        if(paths.length) {
          importPaths = importPaths.concat(prefixPaths(paths, bowerMeta.name));
        }
      });

      return importPaths;
    } catch(e) {
      console.error('Problem with Bower file:', e);
    }
  },

  getScriptPaths: function() {
    return prefixPaths([
      '/assets/scripts/moj.js',
      '/assets/scripts/modules/**/*.js',
      '/assets/scripts/moj-init.js'
      ], bowerMeta.name, true);
  }
};

