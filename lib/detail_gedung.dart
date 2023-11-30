import 'package:flutter/material.dart';

class DetailGedungPage extends StatelessWidget {
  final String nama;
  final String deskripsi;
  final String foto_gedung;

  const DetailGedungPage(
      {required this.nama, required this.deskripsi, required this.foto_gedung});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Gedung'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menambahkan gambar dengan menggunakan widget Image
            Center(
              child: Image.asset(
                foto_gedung, // Ganti dengan path gambar yang sesuai
                width: 200, // Sesuaikan lebar gambar sesuai kebutuhan Anda
                height: 200, // Sesuaikan tinggi gambar sesuai kebutuhan Anda
                fit: BoxFit.cover, // Atur jenis tata letak gambar
              ),
            ),
            SizedBox(height: 16),
            Text(
              '$nama',
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
