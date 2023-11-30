import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:UTS/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var namauser;

  _buatInput(namacontroller, String hint) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: namacontroller,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  void _saveUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _usernameController.text);
  }

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    namauser = prefs.getString('username');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 2.0,
            colors: [
              Colors.green.shade200,
              Colors.teal.shade300,
              Colors.green.shade600,
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40.0),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 15.0,
                ),
                child: Text(
                  "Log in to your account",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(
                  minHeight: 50.0, // Ubah nilai ini sesuai preferensi Anda
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'lib/assets/images/WikiWow.png',
                      height: 100, // Sesuaikan dengan tinggi yang diinginkan
                    ),
                    const SizedBox(height: 20.0),
                    _buatInput(_usernameController, 'Enter your username'),
                    const SizedBox(height: 10.0),
                    _buatInput(_passwordController, 'Enter your password'),
                    const SizedBox(height: 15.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        textStyle: const TextStyle(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                        ),
                      ),
                      onPressed: () {
                        if (_usernameController.text == 'admin' &&
                            _passwordController.text == 'admin') {
                          _saveUsername();
                          _loadUsername();

                          showDialog(
                            context: context,
                            builder: (context) {
                              var namauser2 =
                                  namauser ?? _usernameController.text;
                              return AlertDialog(
                                title: const Text('Anda Berhasil Login'),
                                content: Text(namauser2),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Login Gagal'),
                                content:
                                    const Text('Username dan Password Salah'),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text('Log In'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
