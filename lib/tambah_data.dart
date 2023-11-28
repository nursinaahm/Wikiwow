import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:UTS/list_data.dart';
import 'package:UTS/side_menu.dart';

class TambahData extends StatefulWidget {
  const TambahData({Key? key}) : super(key: key);

  @override
  _TambahDataState createState() => _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  final namaController = TextEditingController();
  final noTelpController = TextEditingController();
  final emailController = TextEditingController();

  Future postData(String nama, String noTelp, String email) async {
    String url = 'http://localhost/api-flutter/index.php';

    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsonBody =
        '{"nama": "$nama", "no_telp": "$noTelp", "email": "$email"}';
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Kontak'),
      ),
      drawer: const SideMenu(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildTextField(
              controller: namaController,
              labelText: 'Nama',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: noTelpController,
              labelText: 'No. Telepon',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: emailController,
              labelText: 'Email',
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                String nama = namaController.text;
                String noTelp = noTelpController.text;
                String email = emailController.text;

                postData(nama, noTelp, email).then((result) {
                  if (result['pesan'] == 'berhasil') {
                    _showSuccessDialog(context);
                  }
                  setState(() {});
                });
              },
              child: const Text('Tambah Kontak'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Data berhasil ditambah'),
          content: const Text(''),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListData(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
