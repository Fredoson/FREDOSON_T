import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Set bottom navigation bar theme here
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.brown,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      home: LoginScreen(),
    );
  }
}
