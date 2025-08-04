import 'package:flutter/material.dart';
import 'add_truck_screen.dart';

class VendorDashboard extends StatefulWidget {
  const VendorDashboard({super.key});

  @override
  State<VendorDashboard> createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> {
  int _selectedIndex = 0;

  List<Map<String, dynamic>> listedTrucks = [
    {
      'name': 'Mini Truck',
      'width': 150,
      'height': 200,
      'price': 1000,
      'available': true,
    },
    {
      'name': 'TATA Ace',
      'width': 180,
      'height': 250,
      'price': 1300,
      'available': false,
    },
  ];

  List<Map<String, dynamic>> bookings = [
    {'id': 1, 'truck': 'Mini Truck', 'status': 'Confirmed'},
    {'id': 2, 'truck': 'TATA Ace', 'status': 'Pending'},
  ];

  double vendorEarnings = 7500;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildListedTrucksTab() {
    return ListView.builder(
      itemCount: listedTrucks.length,
      itemBuilder: (context, index) {
        final truck = listedTrucks[index];
        return Card(
          child: ListTile(
            title: Text(truck['name']),
            subtitle: Text(
              'Width: ${truck['width']} cm | Height: ${truck['height']} cm\nPrice: ₹${truck['price']}',
            ),
            trailing: Switch(
              value: truck['available'],
              onChanged: (value) {
                setState(() {
                  truck['available'] = value;
                });
              },
              activeColor: Colors.green,
              inactiveThumbColor: Colors.red,
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddTruckTab() {
    return Center(
      child: ElevatedButton.icon(
        icon: Icon(Icons.add),
        label: Text("Add New Truck"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTruckScreen(
                onAddTruck: (truckData) {
                  setState(() {
                    listedTrucks.add(truckData);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Truck '${truckData['name']}' added!")),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBookingsTab() {
    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return Card(
          child: ListTile(
            title: Text('Booking #${booking['id']} - ${booking['truck']}'),
            subtitle: Text('Status: ${booking['status']}'),
          ),
        );
      },
    );
  }

  Widget _buildEarningsTab() {
    return Center(
      child: Text(
        'Your Earnings: ₹$vendorEarnings',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      _buildListedTrucksTab(),
      _buildAddTruckTab(),
      _buildBookingsTab(),
      _buildEarningsTab(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vendor Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: 'My Trucks'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Add Truck'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.monetization_on), label: 'Earnings'),
        ],
      ),
    );
  }
}
