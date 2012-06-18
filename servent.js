#!/usr/bin/env node
var coffeeScript = require('coffee-script');
var server = require('./src/server.coffee');
var client = require('./src/client.coffee');
var path = require('path');

if (process.argv.length < 4) {
  console.log("Run with:");
  console.log("$ node-socket-servent HTTP_PORT TCP_PORT [FOLDER] [DEBUG]");
  process.exit();
}

var httpPort = parseInt(process.argv[2]);
var tcpPort = parseInt(process.argv[3]);
var folder = process.argv[4];
var debug = process.argv[5];

if (folder) {
  folder = path.resolve(process.cwd(), folder);
}

server.createHttp(httpPort, folder, debug);
client.createClient(tcpPort, server.broadcast, debug);
