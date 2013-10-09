restify = require 'restify'

server = restify.createServer name: 'golden'
server.use restify.queryParser()

client = restify.createJsonClient
  url: 'http://gd2.mlb.com'

# return 2 character string for a given 0-based integer
int2 = (int) ->
  str = String int
  if str.length is 1 then '0' + str else str

date = new Date()
month = int2 date.getMonth() + 1
day = int2 date.getDate()
# day = int2 2 # uncomment to test a day with no games



client.get "/components/game/mlb/year_2013/month_#{month}/day_#{day}/grid.json", (err, req, res, obj) ->
  server.get path: '/', (request, response, next) ->
    go = true
    data = JSON.parse(res.body).data.games.game

    isDodgerGame = (game) ->
      game.venue.match /dodger/i

    if Array.isArray data
      data.forEach (game) -> if isDodgerGame game then go = false
    else
      if isDodgerGame data then go = false

    response.header 'Access-Control-Allow-Origin', '*'
    response.send 
      url: "/components/game/mlb/year_2013/month_#{month}/day_#{day}/grid.json"
      go: go

    next()

port = process.env.PORT or 3000
server.listen port, -> console.log '%s listening at <%s>', server.name, server.url