import 'package:flutter/material.dart';
import '../dashboard_screen.dart';
import 'register_screen.dart';
import 'admin_dashboard.dart';
import 'vendor_dashboard.dart';
import 'user_dashboard.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _login() {
    final email = emailController.text;
    final password = passwordController.text;

    RegisteredUser? user;
    for (var u in registeredUsers) {
      if (u.email == email && u.password == password) {
        user = u;
        break;
      }
    }

    if (user != null) {
      Widget dashboard;
      if (user.role == 'Admin') {
        dashboard = AdminDashboard();
      } else if (user.role == 'Vendor') {
        dashboard = VendorDashboard();
      } else {
        dashboard = UserDashboard();
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => dashboard),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Login Failed'),
          content: Text('Incorrect email or password'),
        ),
      );
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextButton(
              child: Text("Don't have an account? Register here"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
