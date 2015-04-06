var ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = {
  entry: "./frontend/entry.js",
  output: {
    path: __dirname + '/static',
    filename: 'bundle.js'
  },
  output: {
    filename: "[name].js",
    chunkFilename: "[id].js"
  },
  module: {
    loaders: [
      {
        test: /\.scss$/,
        loader: ExtractTextPlugin.extract(
          'style-loader',
          'css-loader!autoprefixer-loader!sass-loader'
        )
      },
      { test: /\.css$/, loader: 'style-loader!css-loader' }
    ]
  },
  plugins: [
    new ExtractTextPlugin('[name].css')
  ]
};