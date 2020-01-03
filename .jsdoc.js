module.exports = {
    plugins: [
      'node_modules/jsdoc-vuejs'
    ],
    source: {
      include: [
        'app/javascript',
      ],
      includePattern: '\\.(vue|js)$',
    },
    opts: {
      encoding: 'utf8',
    },
  };