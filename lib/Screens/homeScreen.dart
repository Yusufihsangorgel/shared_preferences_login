import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_login/Screens/loginScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? spUsername = '';
  String? spPassword = '';

  Future<void> loginRead() async {
    var sp = await SharedPreferences.getInstance();

    setState(() {
      spUsername = sp.getString("userName") ?? "Username none";
      spPassword = sp.getString("password") ?? "Password none";
    });
  }

  Future<void> exitLogin() async {
    var sp = await SharedPreferences.getInstance();
    sp.remove("userName");
    sp.remove("password");

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
  }

  @override
  void initState() {
    super.initState();
    loginRead();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Ana Sayfa"),
        actions: [
          IconButton(
              onPressed: () {
                exitLogin();
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: spUsername != ''
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Username : $spUsername",
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        "Password : $spPassword",
                        style: TextStyle(fontSize: 30),
                      )
                    ],
                  )
                : CircularProgressIndicator()),
      ),
    );
  }
}
