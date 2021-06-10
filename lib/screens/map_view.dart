import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_task/model/location_model.dart';
import 'package:latlong/latlong.dart';

class MapView extends StatefulWidget {
  final LocationModel location;
  final bool isSelecting;
  final String appBarTitle;

  MapView(
      {@required this.location,
      this.isSelecting = false,
      this.appBarTitle = "Zaznacz na Mapie"});
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final String token =
      'pk.eyJ1Ijoia3Nld2tvOTgiLCJhIjoiY2tvenZsdGY3MDh3aTJvbzZqcm9oNnY4eCJ9.CsZ4n-2ClKDohPV0eM8h_w';
  LatLng _pickedLocation;

  _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  void initState() {
    super.initState();
    _pickedLocation =
        LatLng(widget.location.latitude, widget.location.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor = Colors.deepPurple;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: Text(widget.appBarTitle),
        actions: widget.isSelecting
            ? [
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    Navigator.of(context).pop(_pickedLocation);
                  },
                )
              ]
            : null,
      ),
      body: FlutterMap(
        options: MapOptions(
          center: _pickedLocation,
          zoom: 16.0,
          interactive: true,
          onTap: widget.isSelecting
              ? (point) {
                  _selectLocation(point);
                }
              : null,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/ianahmfac/ckkz8fajc1o4717ocjzryw3hj/tiles/256/{z}/{x}/{y}@2x?access_token=$token",
            additionalOptions: {
              "accessToken": token,
              "id": "mapbox.mapbox-streets-v8"
            },
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: _pickedLocation,
                builder: (ctx) => Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
