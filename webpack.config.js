const { readFileSync } = require('fs');

const babelSettings = JSON.parse(readFileSync('.babelrc'));

module.exports = {
  entry: {
    'index': [ './src/app.js', './src/header.js' ]
  },
  resolve: {
    mainFields: ['svelte', 'browser', 'module', 'main']
  },
  output: {
    path: __dirname + '/public',
    filename: '[name].js',
    chunkFilename: '[name].[id].js'
  },
  module: {
    rules: [
      {
        test: /\.(html|js)$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          query: babelSettings
        }
      },
      {
        test: /\.(html|svelte)$/,
        exclude: /node_modules/,
        use: 'svelte-loader'
      }
    ]
  },
  devtool: 'inline-source-map',
  devServer: {
    contentBase: './public'
  },
}
