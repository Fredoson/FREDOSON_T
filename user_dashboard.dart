import 'package:flutter/material.dart';
import 'search_results_screen.dart';
import 'package:korak_app/screens/track_parcel_screen.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  int _selectedIndex = 0;

  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController widthController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      // Track button tapped
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  TrackParcelScreen(),
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('fpconnector-app')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Item Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: fromController,
              decoration: InputDecoration(labelText: 'From'),
            ),
            TextField(
              controller: toController,
              decoration: InputDecoration(labelText: 'To'),
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: dateController,
                  decoration: InputDecoration(labelText: 'Item to reach before'),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: heightController,
                    decoration: InputDecoration(labelText: 'Height (cm)'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: widthController,
                    decoration: InputDecoration(labelText: 'Width (cm)'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final double userWidth = double.tryParse(widthController.text) ?? 0;
                  final double userHeight = double.tryParse(heightController.text) ?? 0;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchResultsScreen(
                        userWidth: userWidth,
                        userHeight: userHeight,
                      ),
                    ),
                  );
                },
                child: Text('Search Truck'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: 'Track'),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Help'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}
