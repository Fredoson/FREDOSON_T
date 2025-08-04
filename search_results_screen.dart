import 'package:korak_app/models/truck_model.dart';
import 'package:korak_app/screens/truck_booking_screen.dart';
import 'package:flutter/material.dart';
import 'truck_booking_screen.dart';



class SearchResultsScreen extends StatefulWidget {
  final double userWidth;
  final double userHeight;

  const SearchResultsScreen({
    Key? key,
    required this.userWidth,
    required this.userHeight,
  }) : super(key: key);

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  bool showUnder3000 = false;

  final List<Truck> allTrucks = [
    Truck(
      name: 'TATA',
      width: 100,
      height: 150,
      price: 2500,
      imageUrl: 'assets/images/tata.png',
    ),
    Truck(
      name: 'Ashok Leyland',
      width: 130,
      height: 170,
      price: 3200,
      imageUrl: 'assets/images/ashok_leyland.png',
    ),
    Truck(
      name: 'Mahindra & Mahindra',
      width: 200,
      height: 200,
      price: 4500,
      imageUrl: 'assets/images/mahindra.png',
    ),
  ];

  List<Truck> get filteredTrucks {
    return allTrucks.where((truck) {
      bool spaceMatch = truck.width >= widget.userWidth && truck.height >= widget.userHeight;
      bool priceMatch = !showUnder3000 || truck.price < 3000;
      return spaceMatch && priceMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Available Trucks')),
      body: Column(
        children: [
          SwitchListTile(
            title: Text('Show only trucks under ₹3000'),
            value: showUnder3000,
            onChanged: (val) {
              setState(() {
                showUnder3000 = val;
              });
            },
          ),
          Expanded(
            child: filteredTrucks.isEmpty
                ? Center(child: Text('No trucks match your criteria.'))
                : ListView.builder(
              itemCount: filteredTrucks.length,
              itemBuilder: (context, index) {
                final truck = filteredTrucks[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          truck.imageUrl,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 8),
                        Text(truck.name,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Available Space: ${truck.width}cm × ${truck.height}cm'),
                        Text('Price: ₹${truck.price}'),
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TruckBookingScreen(truck: truck),
                                ),
                              );
                            },
                            child: Text('Book Now'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
