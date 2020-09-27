library flutter_map_firestore;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/plugin_api.dart';

typedef Marker MarkerCreator (DocumentSnapshot document);

class FirestoreMarkerPlugin extends MapPlugin {


  @override
  Widget createLayer(LayerOptions opts, MapState map, Stream<Null> stream) {
    FirestoreMarkerLayerOptions fireOption =
    opts as FirestoreMarkerLayerOptions;
    return new StreamBuilder<QuerySnapshot>(
        stream: fireOption._reference.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
              width: 0.0,
              height: 0.0,
            );
          if (snapshot.data.docs.length == 0)
            return Container(
              width: 0.0,
              height: 0.0,
            );

          List<Marker> markers = [];
          for (DocumentSnapshot document in snapshot.data.docs){
            markers.add(fireOption._creator(document));
          }

          MarkerLayerOptions markerOpts = MarkerLayerOptions(markers: markers);

          return MarkerLayer(markerOpts, map, stream);
        });
  }

  @override
  bool supportsLayer(LayerOptions options) {
    return options is FirestoreMarkerLayerOptions;
  }
}

class FirestoreMarkerLayerOptions extends LayerOptions {
  final CollectionReference _reference;
  final MarkerCreator _creator;

  FirestoreMarkerLayerOptions(this._reference, this._creator);
}
