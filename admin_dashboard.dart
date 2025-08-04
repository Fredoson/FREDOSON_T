import 'package:flutter/material.dart';
import 'add_truck_screen.dart';


class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> trucks = [
    {'name': 'TATA Truck', 'width': 200, 'height': 300, 'price': 1500},
    {'name': 'Ashok Leyland', 'width': 220, 'height': 320, 'price': 1700},
    {'name': 'Mahindra', 'width': 210, 'height': 310, 'price': 1600},
  ];


  final List<String> users = ['User1', 'User2', 'User3'];
  final List<String> vendors = ['Vendor1'];
  final List<Map<String, dynamic>> bookings = [
    {'id': 1, 'truck': 'TATA', 'status': 'Pending'},
    {'id': 2, 'truck': 'Mahindra', 'status': 'Approved'},
  ];

  double totalEarnings = 12500;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildUsersTab() {
    return ListView(
      children: [
        Text('Users', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...users.map((user) => ListTile(title: Text(user))),
        Divider(),
        Text('Vendors', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...vendors.map((vendor) => ListTile(title: Text(vendor))),
      ],
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
            trailing: booking['status'] == 'Pending'
                ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.check, color: Colors.green),
                  onPressed: () {
                    setState(() {
                      bookings[index]['status'] = 'Approved';
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      bookings[index]['status'] = 'Rejected';
                    });
                  },
                ),
              ],
            )
                : null,
          ),
        );
      },
    );
  }

  Widget _buildEarningsTab() {
    return Center(
      child: Text(
        'Total Earnings: ₹$totalEarnings',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildManageTrucksTab() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: trucks.length,
            itemBuilder: (context, index) {
              final truck = trucks[index];
              return Card(
                child: ListTile(
                  title: Text(truck['name']),
                  subtitle: Text(
                    'Width: ${truck['width']} cm | Height: ${truck['height']} cm\nPrice: ₹${truck['price']}',
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        trucks.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Deleted ${truck['name']}")),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTruckScreen(
                  onAddTruck: (truckData) {
                    setState(() {
                      trucks.add(truckData);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Truck '${truckData['name']}' added!")),
                    );
                  },
                ),
              ),
            );
          },
          icon: Icon(Icons.add),
          label: Text("Add Truck"),
        ),
      ],
    );
  }



  Widget _buildAnalyticsTab() {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.insert_chart),
          title: Text("Total Orders: ${bookings.length}"),
        ),
        ListTile(
          leading: Icon(Icons.group),
          title: Text("Users: ${users.length} | Vendors: ${vendors.length}"),
        ),
      ],
    );
  }

  final List<Widget Function()> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      _buildUsersTab,
      _buildBookingsTab,
      _buildEarningsTab,
      _buildManageTrucksTab,
      _buildAnalyticsTab,
    ]);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _pages[_selectedIndex](),

      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'Earnings'),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: 'Trucks'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Analytics'),
        ],
      ),
    );
  }
}