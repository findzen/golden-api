{print} = require 'util'
{exec, spawn} = require 'child_process'

task 'server', 'Start local server', ->
  server = spawn 'coffee', ['app.coffee']
  server.stdout.on 'data', (data) -> print data.toString()
  server.stderr.on 'data', (data) -> print data.toString()