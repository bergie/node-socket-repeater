net = require 'net'

exports.createClient = (tcpPort, msgCallback, debug = false) ->
  client = net.connect tcpPort, ->
    console.log "Connected to port #{tcpPort}" if debug

  client.on 'data', (data) ->
    msgCallback data
    console.log data if debug

  client.on 'end', ->
    console.log "Disconnected" if debug
