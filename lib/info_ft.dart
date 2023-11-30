import 'dart:async';
import 'dart:convert';
import 'package:UTS/detail_ft.dart';
import 'package:flutter/material.dart';
import 'package:UTS/side_menu.dart';
import 'package:http/http.dart' as http;

class DataInfoFT extends StatefulWidget {
  const DataInfoFT({super.key});

  @override
  _DataInfoFTState createState() => _DataInfoFTState();
}

class _DataInfoFTState extends State<DataInfoFT> {
  List<Map<String, String>> dataFT = [];
  String url = 'http://localhost/api-flutter/teknik.php';

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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Fakultas Teknik'),
      ),
      drawer: const SideMenu(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: dataFT.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dataFT[index]['judul']!,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Image.asset(
                        dataFT[index]['foto']!,
                        width: screenWidth, // Set lebar sesuai lebar layar
                        height: 200, // Sesuaikan tinggi yang diinginkan
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${dataFT[index]['deskripsi']!}',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
