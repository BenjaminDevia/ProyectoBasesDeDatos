//controlador de books que estan en la base de datos

const {Pool} = require("pg");

//conexion a la base de datos
const pool = new Pool ({
    user: "postgres",
    host: "localhost",
    password: "",
    batabase: "library",
    port: "5432",
});

//logica del controlador
const getBooks = (req, res) => {
    const response = pool.query("SELECT * FROM books");
    res.status(200).json(response.rows);
    console.log(res.status(200).json(response.rows));
};

module.exports = {
    getBooks,
};

