const request = require('supertest');
const app = require('../app'); 
const db = require('../database/db'); // Import koneksi database

jest.mock('../database/db'); // Mocking koneksi database

describe('POST /books', () => {
  afterEach(() => {
    jest.clearAllMocks(); // Membersihkan mock setelah setiap test
  });

  test('Berhasil menambahkan buku', async () => {
    // Mock response dari query database untuk menghitung jumlah buku
    db.query.mockImplementationOnce((query, callback) => {
      callback(null, [{ count: 5 }]); // Simulasi jumlah buku saat ini = 5
    });

    // Mock response untuk insert data
    db.query.mockImplementationOnce((query, values, callback) => {
      callback(null); // Simulasi query berhasil
    });

    const newBook = {
      judul_buku: 'Belajar Node.js',
      pengarang: 'John Doe',
      penerbit: 'Tech Publisher',
    };

    const response = await request(app)
      .post('/books') // Endpoint
      .send(newBook);

    expect(response.status).toBe(201);
    expect(response.body).toEqual({
      kode_buku: 'buku_6',
      ...newBook,
    });

    // Verifikasi query SELECT dan INSERT dipanggil dengan benar
    expect(db.query).toHaveBeenCalledWith(
      'SELECT COUNT(*) AS count FROM buku',
      expect.any(Function)
    );

    expect(db.query).toHaveBeenCalledWith(
      'INSERT INTO buku (kode_buku, judul_buku, pengarang, penerbit) VALUES (?, ?, ?, ?)',
      ['buku_6', newBook.judul_buku, newBook.pengarang, newBook.penerbit],
      expect.any(Function)
    );
  });

  test('Gagal menambahkan buku karena kesalahan database saat SELECT', async () => {
    db.query.mockImplementationOnce((query, callback) => {
      callback(new Error('Database error')); // Simulasi error pada SELECT
    });

    const newBook = {
      judul_buku: 'Belajar Node.js',
      pengarang: 'John Doe',
      penerbit: 'Tech Publisher',
    };

    const response = await request(app)
      .post('/books') // Endpoint
      .send(newBook);

    expect(response.status).toBe(500);
    expect(response.text).toBe('Internal Server Error');
  });

  test('Gagal menambahkan buku karena kesalahan database saat INSERT', async () => {
    db.query.mockImplementationOnce((query, callback) => {
      callback(null, [{ count: 5 }]); // Simulasi jumlah buku saat ini = 5
    });

    db.query.mockImplementationOnce((query, values, callback) => {
      callback(new Error('Database error')); // Simulasi error pada INSERT
    });

    const newBook = {
      judul_buku: 'Belajar Node.js',
      pengarang: 'John Doe',
      penerbit: 'Tech Publisher',
    };

    const response = await request(app)
      .post('/books') // Endpoint
      .send(newBook);

    expect(response.status).toBe(500);
    expect(response.text).toBe('Internal Server Error');
  });
});