# Nomad

This is a library for walking the file system.  It's got a simple interface - you just pass it a function that you want to be run on all the files.  You get back an array that's the result of running your function on each file.  It's essentially 'map' applied to the file system.  Performance should be very fast, since each directory's contents are processed in parallel.

All the options passed in through the first arg are optional.  If given no args, your callback will receive a list of filenames.

As of this writing, there are 3 options:

* processFile: (filename, next) ->
* filter: (filename, next) ->
* hidden: [true|false]

You can give nomad a filename or a dirname as the second arg.  An array will be returned regardless, it will just contain one item in the case that you supplied a filename.

## Usage

```coffee-script
nomad = require 'nomad'
fs = require 'fs'

processFile = (filename, next) ->
  fs.readFile path, 'utf8', next

filter = (filename) ->
  filename.match /\.coffee$/

nomad.walk {processFile: loadFile, filter: filter}, dirname, (err, contents) ->

  # array consisting of all the files
  console.log 'contents:', contents
```

## Why write it, why use it?

I've found myself writing this code numerous times, and I wanted to put it in a place that's reusable for me and accessible to others.  I was looking for a simple function-based interface such as you see here.  Some other libraries create an EventEmitter for the walker.  I don't really see the point.  In my experience I'm usually just trying to do one thing with the files, which is a simpler case than notifying multiple listeners.

It should work fine from vanilla javascript, if it doesn't, let me know.

## LICENSE

(MIT License)

Copyright (c) 2013 Torchlight Software <info@torchlightsoftware.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
