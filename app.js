const express = require('express');
const app = express();
const router = express.Router();

const path = __dirname + '/views/';
const PORT = 8080;
const HOST = '0.0.0.0';

router.use(function (req,res,next) {
  console.log('/' + req.method);
  next();
});

router.get('/', function(req,res){
  res.sendFile(path + 'index.html');
});

router.get('/user', function(req,res){
  res.sendFile(path + 'user.html');
});

app.use(express.static(path));
app.use('/', router);

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
