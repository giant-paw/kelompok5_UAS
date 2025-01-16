const express = require('express');
const booksRoutes = require('./routes/bookdb.js');
const loansRoutes = require('./routes/pinjamdb.js');
const app = express();
require('dotenv').config();
const port = process.env.PORT;

const db = require('./database/db');
const expressLayouts = require('express-ejs-layouts')

//pertemuan 7 session dan bycrpt
const session = require('express-session')
const authRoutes = require('./routes/authRoutes.js');
const { isAuthenticated } = require('./middlewares/middleware.js');


const path = require('path');

// Set folder public sebagai folder static
//app.use(express.static(path.join(__dirname, 'public')));

app.use(express.static('public'));

app.use(expressLayouts);

app.use(express.json());

app.use('/books', booksRoutes);

app.use('/loans', loansRoutes);

app.set('view engine', 'ejs');

app.use(express.urlencoded({ extended: true }));

// Konfigurasi express-session
app.use(session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false,
    cookie: { secure: false } // Set ke true jika menggunakan HTTPS
}));

app.use('/', authRoutes);

app.get('/',(req, res) => {
    res.render('landingPage.ejs', 
        {layout : 'layouts/main-layout.ejs'}
    );
});

app.get('/book-view', isAuthenticated, (req, res) => {
    const { penerbit } = req.query; // Ambil query parameter 'penerbit'
    let query = 'SELECT * FROM buku';
    let params = [];

    if (penerbit) {
        query += ' WHERE penerbit LIKE ?';
        params.push(`%${penerbit}%`); // Menambahkan wildcard % untuk pencarian lebih fleksibel
    }

    db.query(query, params, (err, books) => {
        if (err) return res.status(500).send('Internal Server Error');
        res.render('book', {
            layout: 'layouts/main-layout.ejs',
            books: books,
            selectedPenerbit: penerbit || '' // Kirim penerbit untuk menjaga nilai input tetap ada
        });
    });
});


app.get('/loan-view',isAuthenticated, (req, res) => {
    db.query('SELECT * FROM peminjaman', (err, loans) => {
        if (err) return res.status(500).send('Internal Server Error');
        res.render('pinjam', {
            layout: 'layouts/main-layout.ejs',
            loans: loans
        });
    });
});

app.get('/userDataBuku',isAuthenticated, (req, res) => {
    db.query('SELECT * FROM buku', (err, books) => {
        if (err) return res.status(500).send('Internal Server Error');
        res.render('userDataBuku', {
            layout: 'layouts/main-layout.ejs',
            books: books
        });
    });
});

app.get('/data-anggota',isAuthenticated, (req, res) => {
    db.query(`SELECT * FROM users WHERE role = 'user'`, (err, users) => {
        if (err) return res.status(500).send('Internal Server Error');
        res.render('dataAnggota', {
            layout: 'layouts/main-layout.ejs',
            users: users
        });
    });
});

app.post('/delete-user/:id', (req, res) => {
    const userId = req.params.id;
    db.query('DELETE FROM users WHERE id = ?', [userId], (err, result) => {
      if (err) throw err;
      res.redirect('/data-anggota'); // Redirect after deletion
    });
  });

app.get('/userHomepage', isAuthenticated,(req, res) => {
    res.render('userHomepage', 
        {layout : 'layouts/main-layout.ejs'}
    );
});

app.listen(port,()=> {
    console.log(`server berjalan di http://localhost:${port}`);
});

app.get('/laporan', isAuthenticated,(req, res) => {
    res.render('laporan', 
        {layout : 'layouts/main-layout.ejs'}
    );
});

app.get('/adminHomepage', isAuthenticated,(req, res) => {
    res.render('adminHomepage', 
        {layout : 'layouts/main-layout.ejs'}
    );
});