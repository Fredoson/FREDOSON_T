import 'package:flutter/material.dart';
import 'search_results_screen.dart'; // for Truck model
import 'package:korak_app/models/truck_model.dart';
import 'package:korak_app/screens/user_dashboard.dart'; // adjust path if needed


class TruckBookingScreen extends StatelessWidget {
  final Truck truck;

  const TruckBookingScreen({Key? key, required this.truck}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Truck')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(truck.imageUrl, height: 150),
            SizedBox(height: 16),
            Text(truck.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Space: ${truck.width}cm × ${truck.height}cm'),
            Text('Price: ₹${truck.price}'),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Payment Successful!')),
                  );

                  Future.delayed(Duration(seconds: 1), () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDashboard(),
                      ),
                    );
                  });
                },
                child: Text('Pay & Confirm'),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
