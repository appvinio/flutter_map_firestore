# flutter_map_firestore

Firestore for Flutter Map Plugin: [flutter_map](https://github.com/apptreesoftware/flutter_map)

Add flutter_map_firestore to your pubspec:

Current version: 0.0.4

```yaml
dependencies:
  flutter_map_firestore: ^0.0.4
```

Usage:

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map_firestore/flutter_map_firestore.dart';

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
```

## Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

For help on editing package code, view the [documentation](https://flutter.io/developing-packages/).
