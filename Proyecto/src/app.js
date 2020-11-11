//inicializaremos el servido
const express = require("express");
const bodyParser = require("body-parser");

//Funcion express para iniciar el servidor
const app = express();

//middlewares
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

//cargar rutas
app.use(require("./routes/index"));

//Exportamos app
module.exports = app;
