import 'package:flutter/material.dart';
import 'package:UTS/home_page.dart';
import 'package:UTS/list_data_jurusan.dart';
import 'package:UTS/info_ft.dart';
import 'package:UTS/logout.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
            child: Center(
              child: Text(
                'Menu Aplikasi',
                style: TextStyle(
                  color: Colors.white, // Change the text color
                  fontSize: 15,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.teal),
            title: Text(
              'Home',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.teal),
            title: Text(
              'Data Jurusan',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ListData(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.teal),
            title: Text(
              'Fakultas Teknik',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const InfoFT(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.teal),
            title: Text(
              'Logout',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LogoutPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
