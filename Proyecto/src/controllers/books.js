//controlador de books que estan en la base de datos

const {Pool} = require("pg");

//conexion a la base de datos
const pool = new Pool ({
    user: "postgres",
    host: "localhost",
    password: "5326",
    database: "library",
    port: "5432",
});

//logica del controlador, peticiones get (retorno de valores)
const getBooks = async (req, res) => {
    const response =  await pool.query("SELECT * FROM books");
    res.status(200).json(response.rows);
    console.log(res.status(200).json(response.rows));
};

const getBookById = async (req, res) => {
    const id = parseInt(req.params.id);
    const response =  await pool.query("SELECT * FROM books Where id = $1", [id]);

    res.json(response.rows);
};

//logica del controlador, peticiones post (inserccion de valores)
const createBook = async (req, res) => {
    const { section, title, author } = req.body;
    const response = await pool.query(
        "INSERT INTO books (section, title, author) VALUES ($1,$2, $3)",
        [section, title, author]
    );

    res.json({
        message: "libro añadido con exito",
        body: {
            book: {section, title, author},
        },
    });
};
/* para generar la peticion POST usar postman o similar */

//logica del controlador, peticiones put (actualizacion de valores)
const updateBook = async (req, res) => {
    const id = parseInt(req.params.id);
    const { section, title, author } = req.body;
    console.log(id, section);
    const response = await pool.query(
        "UPDATE books SET  section = $1, title = $2, author = $3 Where id = $4",
        [section, title, author, id]
    );
    
    res.json({ message: "libro actualizado" });
};

//logica del controlador, peticiones delete (eliminacion de valores)
const deleteBook = async (req,res) => {
    const id = parseInt(req.params.id);
    const response = await pool.query("DELETE FROM books where id = $1", [id]);

    res.json("libro eliminado");
};


module.exports = {
    getBooks,
    getBookById,
    createBook,
    updateBook,
    deleteBook,
};

