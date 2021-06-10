
import 'dart:convert';

import 'package:http/http.dart' as http;

class LocationHelper {
  static String generatePreviewImage({double latitude, double longitude}) {
    return "https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/geojson(%7B%22type%22%3A%22Point%22%2C%22coordinates%22%3A%5B$longitude%2C$latitude%5D%7D)/$longitude,$latitude,12/500x300?access_token=pk.eyJ1Ijoia3Nld2tvOTgiLCJhIjoiY2tvenZsdGY3MDh3aTJvbzZqcm9oNnY4eCJ9.CsZ4n-2ClKDohPV0eM8h_w";
  }

  static Future<String> getLocationName(
      double latitude, double longitude) async {
    final url =
        "https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=pk.eyJ1Ijoia3Nld2tvOTgiLCJhIjoiY2tvenZsdGY3MDh3aTJvbzZqcm9oNnY4eCJ9.CsZ4n-2ClKDohPV0eM8h_w";
    final response = await http.get(url);
    String locationName =
        json.decode(response.body)["features"][0]["place_name"];
    return locationName;
  }
}
