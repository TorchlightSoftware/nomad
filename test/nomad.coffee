should = require 'should'
nomad = require '../'
{join, relative} = require 'path'
fs = require 'fs'

rel = (path) -> join __dirname, path
exampleDir = rel '../examples'
getRelname = (name) -> relative exampleDir, name

describe 'nomad - walk', ->

  it 'should return filenames', (done) ->
    nomad.walk {}, exampleDir, (err, filenames) ->
      should.not.exist err
      should.exist filenames
      for name in filenames
        (typeof name).should.eql 'string'
      done()

  it 'should not include hidden files', (done) ->
    nomad.walk {}, exampleDir, (err, filenames) ->
      should.not.exist err
      should.exist filenames
      filenames.map(getRelname).should.not.include '.hidden'
      done()

  it 'should include hidden files', (done) ->
    nomad.walk {hidden: true}, exampleDir, (err, filenames) ->
      should.not.exist err
      should.exist filenames
      filenames.map(getRelname).should.include '.hidden'
      done()

  it 'should run a function', (done) ->
    processFile = (path, next) ->
      fs.readFile path, 'utf8', next

    nomad.walk {processFile: processFile}, exampleDir, (err, contents) ->
      should.not.exist err
      should.exist contents
      for content in contents
        (typeof content).should.eql 'string'
      done()

  it 'should run a filter', (done) ->
    filter = (path, next) ->
      path.match /\.coffee$/

    nomad.walk {filter: filter}, exampleDir, (err, filenames) ->
      should.not.exist err
      should.exist filenames
      for name in filenames
        name.should.match /\.coffee$/
      done()
