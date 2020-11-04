//inicializaremos el servido

//Importaciones de Librerias:
const express = require("express");
const bodyParser = require("body-parser");

//Funcion express para iniciar el servidor
const app = express();

//cargar rutas
app.use(require("./routes/index"));


//body parser
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());


//Exportamos app
module.exports = app;
