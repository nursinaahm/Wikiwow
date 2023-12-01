import 'package:flutter/material.dart';
import 'package:UTS/side_menu.dart';

class OrmawaPage extends StatelessWidget {
  const OrmawaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Organisasi'),
      ),
      drawer: const SideMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Organisasi Mahasiswa",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 2,
                    width: 50,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Merupakan wadah bagi para mahasiswa untuk mengaktualisasikan intelektual, bakat dan kegemaran mahasiswa ke dalam suatu kegiatan yang membawa dampak positif baik bagi lingkungan kampus maupun di masyarakat secara luas. Organisasi Mahasiswa memiliki peran penting dalam pengembangan diri mahasiswa dan turut serta aktif dalam kegiatan sosial.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "List Nama Organisasi:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  buildOrganisasiCard("HMIF", "Himpunan Mahasiswa Informatika"),
                  buildOrganisasiCard(
                      "HMTG", "Himpunan Mahasiswa Teknik Geologi"),
                  buildOrganisasiCard(
                      "HMTI", "Himpunan Mahasiswa Teknik Industri"),
                  buildOrganisasiCard(
                      "HMTS", "Himpunan Mahasiswa Teknik Sipil"),
                  buildOrganisasiCard(
                      "HMTE", "Himpunan Mahasiswa Teknik Elektro"),
                  // Add more cards as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOrganisasiCard(String nama, String deskripsi) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: ListTile(
        title: Text(nama),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$deskripsi'),
          ],
        ),
        // Add other widgets or actions as needed
      ),
    );
  }
}
