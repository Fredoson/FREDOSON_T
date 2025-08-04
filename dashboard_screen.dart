import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final String role; // <-- You're storing the role passed from login

  DashboardScreen({required this.role}); // <-- Constructor accepts it

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$role Dashboard')), // Role in app bar
      body: Center(child: Text('Welcome, $role!')),   // Role in body
    );
  }
}
