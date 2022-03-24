import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_login/Screens/homeScreen.dart';
import 'package:shared_preferences_login/Screens/loginScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<bool> userControl() async {
    var sp = await SharedPreferences.getInstance();

    String spUsername = sp.getString("userName") ?? "Username none";
    String spPassword = sp.getString("password") ?? "Password none";

    if (spUsername == "admin" && spPassword == "123") {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: userControl(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool loginPermission = snapshot.hasData;
            return loginPermission ? HomeScreen() : LoginScreen();
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
