var path = require("path");
var express = require("express");

var DIST_DIR = __dirname;
var PORT = 3000;
var app = express();

app.use(express.static(DIST_DIR));

app.get("*", function (req, res) {
  res.sendFile(path.join(DIST_DIR, "index.html"));
});

app.listen(PORT);
