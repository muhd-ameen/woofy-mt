import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lylac/constanats/const.dart';
import 'package:lylac/screens/homePage.dart';

class MapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  const MapScreen({Key key, @required this.latitude, @required this.longitude})
      : super(key: key);

  @override
  _MapScreenState createState() =>
      _MapScreenState(this.latitude, this.longitude);
}

class _MapScreenState extends State<MapScreen> {
  double latitude;
  double longitude;
  _MapScreenState(this.latitude, this.longitude);

  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(11.2550878, 75.828256);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMap = MapType.normal;

  static final CameraPosition _position1 = CameraPosition(
      bearing: 192.833,
      target: LatLng(11.2550878, 75.828256),
      tilt: 59.440,
      zoom: 11.0);

  Future<void> _goToPosition1() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
  }

  @override
  void initState() {
    super.initState();
    setMarker();
    _onAddMarkerButton();

    print('$latitude ---- $longitude');
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: kThemeColor,
      child: Icon(
        icon,
        size: 35.0,
      ),
    );
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMap =
          _currentMap == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }
  BitmapDescriptor customIcon;
  setMarker(){

  }

  _onAddMarkerButton() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),

        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Lat:$latitude',
          snippet: 'log:$longitude',
        ),
        icon:  BitmapDescriptor.defaultMarker
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
            mapType: _currentMap,
            markers: _markers,
            onCameraMove: _onCameraMove,
          ),
          Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back),
                    ),
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                          'https://www.kindpng.com/picc/m/129-1292099_black-businessman-png-cool-black-business-man-transparent.png'),
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
