import 'package:UTS/fasilitas.dart';
import 'package:UTS/data_gedung.dart';
import 'package:UTS/info_ft.dart';
import 'package:UTS/ormawa_ft.dart';
import 'package:UTS/list_data_jurusan.dart';
import 'package:flutter/material.dart';
import 'package:UTS/side_menu.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {
      'icon': Icons.person,
      'item': 'Informasi FT',
      'page': DataInfo(),
      'color': Colors.teal,
    },
    {
      'icon': Icons.person,
      'item': 'Data Jurusan',
      'page': ListData(),
      'color': Colors.teal,
    },
    {
      'icon': Icons.account_balance_sharp,
      'item': 'Data Gedung',
      'page': DataGedung(),
      'color': Colors.teal,
    },
    {
      'icon': Icons.attractions_rounded,
      'item': 'Data Fasilitas',
      'page': DataFasilitas(),
      'color': Colors.teal,
    },
    {
      'icon': Icons.person,
      'item': 'Data Organisasi',
      'page': OrmawaPage(),
      'color': Colors.teal,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
     drawer: const SideMenu(),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => menuItems[index]['page'],
                ),
              );
            },
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    menuItems[index]['icon'],
                    size: 48,
                    color: menuItems[index]['color'],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    menuItems[index]['item'],
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
