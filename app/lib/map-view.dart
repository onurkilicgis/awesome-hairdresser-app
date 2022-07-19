import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewPage extends StatelessWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Map(),
    );
  }
}

class Map extends StatefulWidget {
  @override
  MapState createState() => MapState();
}

class MapState extends State<Map> {
  int tiklanmaSayisi = 0;
  double buttonOpacity = 0.0;
  LatLng latLng2 = LatLng(0, 0);

  late GoogleMapController controller;
  Set<Marker> _markers = Set();
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(38.60027, 27.08397),
      tilt: 59.440717697143555,
      zoom: 10.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GoogleMap(
          onMapCreated: (GoogleMapController controller) {},
          onTap: (LatLng latLng) {
            latLng2 = latLng;
            _markers.add(Marker(
              markerId: MarkerId('mark'),
              position: latLng,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen,
              ),
              draggable: true,
              zIndex: 10,
              infoWindow: InfoWindow(
                title: 'merhaba',
              ),
            ));
            setState(() {
              tiklanmaSayisi++;

              if (tiklanmaSayisi >= 1) {
                buttonOpacity = 1.0;
              } else {
                buttonOpacity = 0.0;
              }
            });
          },
          markers: Set<Marker>.of(_markers),
          mapType: MapType.hybrid,
          initialCameraPosition: _kLake,
        ),
      ),
    );
  }
}
