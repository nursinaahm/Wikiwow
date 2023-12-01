import 'package:flutter/material.dart';

class DetailFasilitasPage extends StatelessWidget {
  final String nama;
  final String deskripsi;
  final String foto_fasilitas;

  const DetailFasilitasPage(
      {required this.nama,
      required this.deskripsi,
      required this.foto_fasilitas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Fasilitas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menambahkan gambar dengan menggunakan widget Image
            Center(
              child: Image.asset(
                foto_fasilitas, // Ganti dengan path gambar yang sesuai
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
            Text('$deskripsi', textAlign: TextAlign.justify),
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
