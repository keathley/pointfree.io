# pointfree.io
A web site for converting haskell code into pointfree haskell code

## About

This is just a basic web service built in scotty that converts haskell code into pointfree haskell code.  I built it as a way of learning more about building services in Haskell.  It's really just a toy.  Don't take it too seriously.

## Getting started / Installation

### Building

If you want to build the service then you will need Haskell and cabal.  After that it should be as easy as:

    $ cabal configure && cabal install

### Running

Once you have that done you should be able to export your PORT variable and run the service like so:

    $ export PORT=3000
    $ cabal run

### Frontend components

The compiled assets are provided with the repo.  However, if you would like to build the frontend components yourself
then press on.

All of the frontend components are located in the `frontend` directory.  They are built with webpack.  Assuming that you have a working version of node or io.js installed simply run:

    $ npm install
    $ webpack

and you should be good.

## TODO

* Add tests
* Allow endpoints to accept json data
* ...
* Profit? JKLOL probably not.

## Contributing

I would love to hear your feedback or receive Pull Requests.  Feel free to reach out to me @ChrisKeathley or c@keathley.io
