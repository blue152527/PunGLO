import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowMap extends StatefulWidget {
  @override
  _ShowMapState createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  // Field

  static LatLng gloCenter = LatLng(13.881419, 100.505119);
  CameraPosition cameraPosition = CameraPosition(
    target: gloCenter,
    zoom: 16.0,
  );

  // Method
  Marker gloMarker() {
    return Marker(
      infoWindow: InfoWindow(title: 'สำนักงานสลากกินแบ่งรัฐบาล', snippet: '359 ถ.นนทบุรี ต.ท่าทราย อ.เมือง จ.นนทบุรี 11000'),
      markerId: MarkerId('PunGLO'),
      position: gloCenter,
    );
  }

  Set<Marker> setMarker() {
    return <Marker>[
      gloMarker(),
    ].toSet();
  }

  Widget showGoogleMap() {
    return GoogleMap(markers: setMarker(),
      initialCameraPosition: cameraPosition,
      mapType: MapType.normal,
      onMapCreated: (GoogleMapController googleMapController) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return showGoogleMap();
  }
}
