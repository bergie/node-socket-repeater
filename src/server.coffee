http = require 'express'
sockjs = require 'sockjs'
net = require 'net'

exports.createServers = (httpPort, tcpPort, folder = null, debug = false) ->
  folder = process.cwd() unless folder

  server = http.createServer()
  server.use http.static folder
  server.use http.directory folder

  clients = []

  # Broadcast a message to all other connected clients
  broadcast = (msg, sender) ->
    for client in clients
      continue if client is sender
      client.write msg

  webSocket = sockjs.createServer()
  webSocket.on 'connection', (client) ->
    # Register client to list
    clients.push client

    client.on 'data', (msg) ->
      console.log msg if debug
      broadcast msg, client
    
    client.on 'close', ->
      # Remove client from list
      clients.splice clients.indexOf(client), 1

  webSocket.installHandlers server,
    prefix: '/comm'

  server.listen httpPort, ->
    console.log "HTTP/WebSockets server listening at port #{httpPort}"

  tcp = net.createServer (client) ->
    client.setEncoding 'utf-8'

    client.on 'connect', ->
      clients.push client

    client.on 'data', (msg) ->
      console.log msg if debug
      broadcast msg, client

    client.on 'end', ->
      # Remove client from list
      clients.splice clients.indexOf(client), 1

  tcp.listen tcpPort, ->
    console.log "Socket server listening at port #{tcpPort}"
