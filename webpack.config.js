module.exports = {
  entry: "./frontend/entry.js",
  output: {
    path: __dirname + '/static',
    filename: 'bundle.js'
  },
  module: {
    loaders: [
      {
        test: /\.scss$/,
        loaders: [
          'style-loader',
          'css-loader',
          'autoprefixer-loader',
          'sass-loader'
        ]
      },
      { test: /\.css$/, loader: 'style-loader!css-loader' }
    ]
  }
};