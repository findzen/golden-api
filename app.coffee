restify = require 'restify'

server = restify.createServer name: 'golden'
server.use restify.queryParser()

client = restify.createJsonClient
  url: 'http://gd2.mlb.com'

client.get '/components/game/mlb/year_2013/month_09/day_14/grid.json', (err, req, res, obj) ->
  # console.log err, req, res, obj

  server.get path: '/', (req, res, next) ->
    res.send res
    # console.log res
    next()

server.listen 3000, ->
  console.log '%s listening at <%s>', server.name, server.url
