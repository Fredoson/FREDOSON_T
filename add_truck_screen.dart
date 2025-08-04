import 'package:flutter/material.dart';

class AddTruckScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddTruck;

  const AddTruckScreen({Key? key, required this.onAddTruck}) : super(key: key);

  @override
  State<AddTruckScreen> createState() => _AddTruckScreenState();
}

class _AddTruckScreenState extends State<AddTruckScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  void _submitTruck() {
    final truckData = {
      'name': nameController.text,
      'width': double.tryParse(widthController.text) ?? 0,
      'height': double.tryParse(heightController.text) ?? 0,
      'price': double.tryParse(priceController.text) ?? 0,
    };

    widget.onAddTruck(truckData); // send to AdminDashboard
    Navigator.pop(context); // go back
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Truck')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Truck Name')),
            TextField(controller: widthController, decoration: InputDecoration(labelText: 'Width (cm)'), keyboardType: TextInputType.number),
            TextField(controller: heightController, decoration: InputDecoration(labelText: 'Height (cm)'), keyboardType: TextInputType.number),
            TextField(controller: priceController, decoration: InputDecoration(labelText: 'Price (₹)'), keyboardType: TextInputType.number),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _submitTruck, child: Text('Add Truck')),
          ],
        ),
      ),
    );
  }
}
