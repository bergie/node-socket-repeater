Socket repeater for Node.js
===========================

This simple Node.js application serves the purpose of passing messages between connected TCP and WebSocket clients. Any message received from one of them is automatically passed to all others.

## Installation

* Install Node.js 0.6.x
* Check out this repository
* Install NPM dependencies with `npm install`

## Usage

In addition to passing socket data, the application also serves static files located under a given folder. This is useful for serving the actual web application that needs such socket functionality.

When starting the application, you can give it three parameters:

* The HTTP port to listen to (for example, `80`)
* The TCP port to listen to (for example, `3000`)
* The path under which files ought to be served

    $ ./app.js 80 3000 my/app/folder

## Example

There is a simple example provided. To start it, run:

    $ ./app.js 80 3000 example

Then connect with a browser to <http://localhost>.

You also need to telnet to the socket server:

    $ telnet localhost 3000

Now anything you write in the telnet session will be shown on the web page instantly.

If you want to send data from the browser, you can run the following in your JavaScript console:

    sockjs.send('My cool message');
