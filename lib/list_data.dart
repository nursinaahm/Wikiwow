import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:UTS/edit_data.dart';
import 'package:UTS/side_menu.dart';
import 'package:UTS/tambah_data.dart';

class ListData extends StatefulWidget {
  const ListData({super.key});

  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  List<Map<String, String>> dataKontak = [];
  String url = 'http://localhost/api-flutter/index.php';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        dataKontak = List<Map<String, String>>.from(data.map((item) {
          return {
            'nama': item['nama'] as String,
            'no_telp': item['no_telp'] as String,
            'email': item['email'] as String,
            'id': item['id'] as String,
          };
        }));
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future deleteData(int id) async {
    final response = await http.delete(Uri.parse('$url?id=$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to delete data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Data Kontak'),
      ),
      drawer: const SideMenu(),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const TambahData(),
                ),
              );
            },
            child: const Text('Tambah Data Kontak'),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: dataKontak.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: ListTile(
                  title: Text(dataKontak[index]['nama']!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('No. Telepon: ${dataKontak[index]['no_telp']}'),
                      Text('Email: ${dataKontak[index]['email']}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.visibility),
                        onPressed: () {
                          lihatKontak(context, index);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          editKontak(context, index);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          deleteData(int.parse(dataKontak[index]['id']!))
                              .then((result) {
                            if (result['pesan'] == 'berhasil') {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Data berhasil dihapus'),
                                    content: const Text(''),
                                    actions: [
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ListData(),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ]),
    );
  }

  void editKontak(BuildContext context, int index) {
    final Map<String, dynamic> Kontak = dataKontak[index];
    final String id = Kontak['id'] as String;
    final String nama = Kontak['nama'] as String;
    final String noTelp = Kontak['no_telp'] as String;
    final String email = Kontak['email'] as String;

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
          EditData(id: id, nama: nama, noTelp: noTelp, email: email),
    ));
  }

  void lihatKontak(BuildContext context, int index) {
    final Kontak = dataKontak[index];
    final nama = Kontak['nama'] as String;
    final noTelp = Kontak['no_telp'] as String;
    final email = Kontak['email'] as String;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          title: const Center(child: Text('Detail Kontak')),
          content: SizedBox(
            height: 80,
            child: Column(
              children: [
                Text('Nama : $nama'),
                Text('No. Telepon: $noTelp'),
                Text('Email: $email'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
