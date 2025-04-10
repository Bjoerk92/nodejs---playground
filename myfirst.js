var http = require('http')
var fs = require('fs')
var dt = require('./TimeModule')

http.createServer(function (req, res)
{
    fs.readFile('htmls/demo.html', function(err, data){
    res.writeHead(200, {'Content-type':'text/html'});
    res.write(data)
    res.write("the date and time are currently: " + dt.myDateTime());
    res.end()
    })
}).listen(8080);