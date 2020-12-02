import 'dart:async';

import 'package:flutter/services.dart';

class Geofire {
  MethodChannel _channel = new MethodChannel('geofire');

  EventChannel _stream = new EventChannel('geofireStream');

  String onKeyEntered = "onKeyEntered";
  String onGeoQueryReady = "onGeoQueryReady";
  String onKeyMoved = "onKeyMoved";
  String onKeyExited = "onKeyExited";

  Stream<dynamic> _queryAtLocation;

  Future<bool> initialize(String path) async {
    dynamic r = await _channel
        .invokeMethod('GeoFire.start', <String, dynamic>{"path": path});
    return r ?? false;
  }

  Future<bool> setLocation(String id, double latitude, double longitude) async {
    bool isSet = await _channel.invokeMethod('setLocation',
        <String, dynamic>{"id": id, "lat": latitude, "lng": longitude});
    return isSet;
  }

  Future<bool> removeLocation(String id) async {
    bool isSet = await _channel
        .invokeMethod('removeLocation', <String, dynamic>{"id": id});
    return isSet;
  }

  Future<bool> stopListener() async {
    bool isSet =
        await _channel.invokeMethod('stopListener', <String, dynamic>{});
    return isSet;
  }

  Future<Map<String, dynamic>> getLocation(String id) async {
    Map<dynamic, dynamic> response =
        await _channel.invokeMethod('getLocation', <String, dynamic>{"id": id});

    Map<String, dynamic> location = new Map();

    response.forEach((key, value) {
      location[key] = value;
    });

    print(location);

    return location;
  }

  Stream<dynamic> queryAtLocation(double lat, double lng, double radius) {
    _channel.invokeMethod('queryAtLocation',
        {"lat": lat, "lng": lng, "radius": radius}).then((result) {
      print("result" + result);
    }).catchError((error) {
      print("Error " + error);
    });

    if (_queryAtLocation == null) {
      _queryAtLocation = _stream.receiveBroadcastStream();
    }
    return _queryAtLocation;
  }

  /*
  Update the query with the specified lat/lng and radius without the need to re-start the listner.
  */
  Future<bool> updateQuery(
      double latitude, double longitude, double radius) async {
    bool isSet = await _channel.invokeMethod('updateQuery',
        <String, dynamic>{"lat": latitude, "lng": longitude, "radius": radius});
    return isSet;
  }
}
