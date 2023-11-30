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
  List<Map<String, String>> dataJurusan = [];
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
        dataJurusan = List<Map<String, String>>.from(data.map((item) {
          return {
            'nama': item['nama'] as String,
            'deskripsi': item['deskripsi'] as String,
            'id': item['id'] as String,
          };
        }));
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Future deleteData(int id) async {
  //   final response = await http.delete(Uri.parse('$url?id=$id'));
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body);
  //   } else {
  //     throw Exception('Failed to delete data');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Data Jurusan'),
      ),
      drawer: const SideMenu(),
      body: Column(children: <Widget>[
        // Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: ElevatedButton(
        //     onPressed: () {
        //       Navigator.pushReplacement(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => const TambahData(),
        //         ),
        //       );
        //     },
        //     child: const Text('Tambah Data Kontak'),
        //   ),
        // ),
        Expanded(
          child: ListView.builder(
            itemCount: dataJurusan.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: ListTile(
                  title: Text(dataJurusan[index]['nama']!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nama Jurusan: ${dataJurusan[index]['nama']}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.visibility),
                        onPressed: () {
                          lihatJurusan(context, index);
                        },
                      ),
                      // IconButton(
                      //   icon: const Icon(Icons.edit),
                      //   onPressed: () {
                      //     editKontak(context, index);
                      //   },
                      // ),
                      // IconButton(
                      //   icon: const Icon(Icons.delete),
                      //   onPressed: () {
                      //     deleteData(int.parse(dataKontak[index]['id']!))
                      //         .then((result) {
                      //       if (result['pesan'] == 'berhasil') {
                      //         showDialog(
                      //           context: context,
                      //           builder: (context) {
                      //             return AlertDialog(
                      //               title: const Text('Data berhasil dihapus'),
                      //               content: const Text(''),
                      //               actions: [
                      //                 TextButton(
                      //                   child: const Text('OK'),
                      //                   onPressed: () {
                      //                     Navigator.pushReplacement(
                      //                       context,
                      //                       MaterialPageRoute(
                      //                         builder: (context) =>
                      //                             const ListData(),
                      //                       ),
                      //                     );
                      //                   },
                      //                 ),
                      //               ],
                      //             );
                      //           },
                      //         );
                      //       }
                      //     });
                      //   },
                      // ),
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

  // void editKontak(BuildContext context, int index) {
  //   final Map<String, dynamic> Kontak = dataKontak[index];
  //   final String id = Kontak['id'] as String;
  //   final String nama = Kontak['nama'] as String;
  //   final String noTelp = Kontak['no_telp'] as String;
  //   final String email = Kontak['email'] as String;

  //   Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) =>
  //         EditData(id: id, nama: nama, noTelp: noTelp, email: email),
  //   ));
  // }
void lihatJurusan(BuildContext context, int index) {
  final Jurusan = dataJurusan[index];
  final nama = Jurusan['nama'] as String;
  final deskripsi = Jurusan['deskripsi'] as String;

  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => Scaffold(
      appBar: AppBar(
        title: Text('Detail Jurusan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detail Jurusan',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 16),
                Text(
                  'Nama : $nama',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Deskripsi : $deskripsi'),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the detail page
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  ));
}
}
