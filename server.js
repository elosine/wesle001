var express = require('express');
var app = express();
var path = require('path');
var server = require('http').createServer(app);
const PORT = process.env.PORT || 5000
app.use(express.static(path.join(__dirname, '/public')));
app.get('/', function(req, res) {
  res.sendFile(path.join(__dirname, '/public/index.html'));
});
server.listen(PORT, () => console.log(`Listening on ${ PORT }`));

const OSC = require('osc-js')

// const osc = new OSC({
//   plugin: new OSC.BridgePlugin({
//
//     wsServer: {
//       host: '192.168.1.107',
//       port: 8080
//     },
//     UdpClient:{
//       host:'192.168.1.107',
//       port: 57120
//     }
//   })
// })

const osc = new OSC({
  plugin: new OSC.BridgePlugin({
    wsServer: {
      host: '192.168.1.107',
      port: 8080
    },
    udpClient: {
      port: 57120
    }
  })
})

osc.open() // start a WebSocket server on port 8080
