import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:UTS/detail_ft.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:UTS/edit_data.dart';
import 'package:UTS/side_menu.dart';
// import 'package:UTS/tambah_data.dart';

class InfoFT extends StatefulWidget {
  const InfoFT({super.key});

  @override
  _InfoFTState createState() => _InfoFTState();
}

class _InfoFTState extends State<InfoFT> {
  List<Map<String, String>> dataFT = [];
  String url = 'http://localhost/pemmob/wikiwow/teknik.php';

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
        dataFT = List<Map<String, String>>.from(data.map((item) {
          return {
            'foto': item['foto'] as String,
            'judul': item['judul'] as String,
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
        title: const Text('Informasi Fakultas Teknik'),
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
            itemCount: dataFT.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: ListTile(
                  leading: Image.asset(
                    dataFT[index][
                        'foto']!, // Replace this with the path to your image asset
                    width: 50, // Set the desired width
                    height: 50, // Set the desired height
                    fit: BoxFit
                        .cover, // Adjust the fit based on your image requirements
                  ),

                  title: Text(dataFT[index]['judul']!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Judul: ${dataFT[index]['judul']}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.visibility),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailFTPage(
                                      judul: dataFT[index]['judul']!,
                                      deskripsi: dataFT[index]
                                          ['deskripsi']!,
                                          foto: dataFT[index]['foto']!
                                          )));
                          // lihatJurusan(context, index);
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
}
