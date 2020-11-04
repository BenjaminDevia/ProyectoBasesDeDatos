const { Router } = require("express");
const router = Router();

const {getBooks} = require("../controllers/books");

//ruta de libros
router.get("/", getBooks);

module.exports = router;