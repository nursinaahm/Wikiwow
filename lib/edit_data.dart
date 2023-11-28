import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:UTS/list_data.dart';
import 'package:UTS/side_menu.dart';

class EditData extends StatefulWidget {
  const EditData({
    Key? key,
    required this.nama,
    required this.noTelp,
    required this.email,
    required this.id,
  }) : super(key: key);

  final String nama;
  final String noTelp;
  final String email;
  final String id;

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController noTelpController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future updateData(String nama, String noTelp, String email) async {
    final baseUrl = 'http://localhost/api-flutter/index.php';

    final headers = <String, String>{'Content-Type': 'application/json'};
    final requestBody = <String, dynamic>{
      'id': widget.id,
      'nama': nama,
      'no_telp': noTelp,
      'email': email,
    };

    final response = await http.put(
      Uri.parse(baseUrl),
      headers: headers,
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to update data');
    }
  }

  @override
  void initState() {
    super.initState();
    namaController.text = widget.nama;
    noTelpController.text = widget.noTelp;
    emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data Kontak'),
      ),
      drawer: const SideMenu(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(
              controller: namaController,
              hintText: 'Nama Kontak',
            ),
            const SizedBox(height: 16), // Add some spacing
            _buildTextField(
              controller: noTelpController,
              hintText: 'No. Telepon',
            ),
            const SizedBox(height: 16), // Add more spacing
            _buildTextField(
              controller: emailController,
              hintText: 'Email',
            ),
            const SizedBox(height: 32), // Add more spacing
            ElevatedButton(
              onPressed: () async {
                final nama = namaController.text;
                final noTelp = noTelpController.text;
                final email = emailController.text;

                final result = await updateData(nama, noTelp, email);

                if (result['pesan'] == 'berhasil') {
                  _showSuccessDialog(context);
                }
                setState(() {});
              },
              child: const Text('Update Kontak'),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Data berhasil diupdate'),
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
