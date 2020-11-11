const { Router } = require("express");
const router = Router();

const {
    getBooks, 
    getBookById, 
    createBook,
    updateBook,
    deleteBook,
} = require("../controllers/books");

//ruta de libros
router.get("/books", getBooks);
router.get("/books/:id", getBookById);

router.post("/books", createBook);

router.put("/books/:id", updateBook);

router.delete("/books/:id", deleteBook);

module.exports = router;