import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';



class MapScreen extends StatefulWidget {
   const MapScreen({super.key, required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  @override
  _MapScreenState createState() {

    return _MapScreenState(latitude: latitude,longitude: longitude,);
  }
}

class _MapScreenState extends State<MapScreen> {
  final double latitude;
  final double longitude;
  late LatLng _selectedLocation;

  _MapScreenState({required this.latitude, required this.longitude}) {
    _selectedLocation = LatLng(latitude, longitude);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(latitude, longitude),
        zoom: 16.0,
        // onTap: (LatLng latlng) {
        //   setState(() {
        //     _selectedLocation = latlng;
        //   });
        // },
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: _selectedLocation,
              builder: (ctx) => const Icon(Icons.location_pin, color: Colors.red, size: 50.0),
            ),
          ],
        ),
      ],
    );
  }
}
