import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_firestore/flutter_map_firestore.dart';
import 'package:latlong/latlong.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MapScaffold(),
    );
  }
}

class MapScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Map(),
    );
  }
}


class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new FlutterMap(
      options: new MapOptions(
        center: LatLng(49.4959962, 18.8953505),
        plugins: [FirestoreMarkerPlugin()],
      ),
      layers: [
        new TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        new FirestoreMarkerLayerOptions(FirebaseFirestore.instance.collection('markers'), //connect own firestore collection
                (document) {
              GeoPoint point = document.data()["location"]; //use for example Firestore GeoPoint
              return Marker(
                  width: 50.0,
                  height: 50.0,
                  point: LatLng(point.latitude, point.longitude),
                  builder: (ctx) => new Container(
                    child: new FlutterLogo(),
                  ));
            }),
      ],
    );
  }
}
