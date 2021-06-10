import 'package:flutter/material.dart';

class LocationModel {
  final double latitude;
  final double longitude;
  final String address;

  const LocationModel({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });
}
