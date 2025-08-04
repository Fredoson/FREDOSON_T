import 'package:flutter/material.dart';

class RegisteredUser {
  final String email;
  final String password;
  final String role;

  RegisteredUser({required this.email, required this.password, required this.role});
}

List<RegisteredUser> registeredUsers = [];

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String selectedRole = 'User';

  static bool isAdminRegistered = false;
  static bool isVendorRegistered = false;

  void _register() {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showMessage("Please fill all fields");
      return;
    }

    if (selectedRole == 'Admin' && isAdminRegistered) {
      _showMessage("Admin is already registered");
      return;
    }

    if (selectedRole == 'Vendor' && isVendorRegistered) {
      _showMessage("Vendor is already registered");
      return;
    }

    if (selectedRole == 'Admin') isAdminRegistered = true;
    if (selectedRole == 'Vendor') isVendorRegistered = true;

    registeredUsers.add(RegisteredUser(
      email: email,
      password: password,
      role: selectedRole,
    ));

    _showMessage("Registration Successful!", success: true);
  }

  void _showMessage(String msg, {bool success = false}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(success ? 'Success' : 'Error'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (success) Navigator.pop(context); // back to login
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            DropdownButton<String>(
              value: selectedRole,
              items: ['User', 'Admin', 'Vendor'].map((role) {
                return DropdownMenuItem(value: role, child: Text(role));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRole = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
