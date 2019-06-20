var path = require("path");
var express = require("express");

var DIST_DIR = __dirname;
var port = process.env.PORT || 3000;
var app = express();

app.use(express.static(DIST_DIR));

app.get("/", function (req, res) {
  res.sendFile(path.join(DIST_DIR, "index.html"));
});

app.get("/help", function(req, res) {
  res.sendFile(path.join(DIST_DIR, "help.html"));
});

app.listen(port);
