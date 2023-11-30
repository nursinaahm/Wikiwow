import 'package:flutter/material.dart';

class DetailFTPage extends StatelessWidget {
  final String judul;
  final String deskripsi;
  final String foto;

  const DetailFTPage({required this.judul, required this.deskripsi, required this.foto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Informasi Fakultas Teknik'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menambahkan gambar dengan menggunakan widget Image
            Center(
              child: Image.asset(
                foto, // Ganti dengan path gambar yang sesuai
                width: 400, // Sesuaikan lebar gambar sesuai kebutuhan Anda
                height: 200, // Sesuaikan tinggi gambar sesuai kebutuhan Anda
                fit: BoxFit.cover, // Atur jenis tata letak gambar
              ),
            ),
            SizedBox(height: 16),
            Text(
              '$judul',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('$deskripsi'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
              },
              child: Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}
