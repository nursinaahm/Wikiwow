import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:UTS/login_page.dart';
import 'package:UTS/side_menu.dart';

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout Page'),
      ),
      drawer: const SideMenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Anda yakin ingin logout?',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.teal[900], // Warna tombol
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: () {
                _logout(context);
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) async {
  // Clear the username and set isLoggedIn to false
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('username');
  await prefs.setBool('isLoggedIn', false);

  // Navigate to the login page
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
}
}