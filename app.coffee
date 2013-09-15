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
    response.header 'Access-Control-Allow-Origin', '*'
    
    response.send 
      url: "/components/game/mlb/year_2013/month_#{month}/day_#{day}/grid.json"
      body: res.body
      
    next()

server.listen 3000, ->
  console.log '%s listening at <%s>', server.name, server.url
