import 'dart:async';

import 'package:flutter/services.dart';

class Geofire {
  MethodChannel _channelAlpha = new MethodChannel('geofireAlpha');
  EventChannel _streamAlpha = new EventChannel('geofireStreamAlpha');

  MethodChannel _channelBeta = new MethodChannel('geofireBeta');
  EventChannel _streamBeta = new EventChannel('geofireStreamBeta');

  MethodChannel _channelGama = new MethodChannel('geofireGama');
  EventChannel _streamGama = new EventChannel('geofireStreamGama');

  String onKeyEntered = "onKeyEntered";
  String onGeoQueryReady = "onGeoQueryReady";
  String onKeyMoved = "onKeyMoved";
  String onKeyExited = "onKeyExited";

  Stream<dynamic> _queryAtLocationAlpha;
  Stream<dynamic> _queryAtLocationBeta;
  Stream<dynamic> _queryAtLocationGama;

  Future<bool> initializeAlpha(String path) async {
    dynamic r = await _channelAlpha
        .invokeMethod('GeoFire.start', <String, dynamic>{"path": path});
    return r ?? false;
  }

  Future<bool> initializeBeta(String path) async {
    dynamic r = await _channelBeta
        .invokeMethod('GeoFire.start', <String, dynamic>{"path": path});
    return r ?? false;
  }

  Future<bool> initializeGama(String path) async {
    dynamic r = await _channelGama
        .invokeMethod('GeoFire.start', <String, dynamic>{"path": path});
    return r ?? false;
  }

  Future<bool> setLocationAlpha(
      String id, double latitude, double longitude) async {
    bool isSet = await _channelAlpha.invokeMethod('setLocation',
        <String, dynamic>{"id": id, "lat": latitude, "lng": longitude});
    return isSet;
  }

  Future<bool> setLocationBeta(
      String id, double latitude, double longitude) async {
    bool isSet = await _channelBeta.invokeMethod('setLocation',
        <String, dynamic>{"id": id, "lat": latitude, "lng": longitude});
    return isSet;
  }

  Future<bool> setLocationGama(
      String id, double latitude, double longitude) async {
    bool isSet = await _channelGama.invokeMethod('setLocation',
        <String, dynamic>{"id": id, "lat": latitude, "lng": longitude});
    return isSet;
  }

  Future<bool> removeLocationAlpha(String id) async {
    bool isSet = await _channelAlpha
        .invokeMethod('removeLocation', <String, dynamic>{"id": id});
    return isSet;
  }

  Future<bool> removeLocationBeta(String id) async {
    bool isSet = await _channelBeta
        .invokeMethod('removeLocation', <String, dynamic>{"id": id});
    return isSet;
  }

  Future<bool> removeLocationGama(String id) async {
    bool isSet = await _channelGama
        .invokeMethod('removeLocation', <String, dynamic>{"id": id});
    return isSet;
  }

  Future<bool> stopListenerAlpha() async {
    bool isSet =
        await _channelAlpha.invokeMethod('stopListener', <String, dynamic>{});
    return isSet;
  }

  Future<bool> stopListenerBeta() async {
    bool isSet =
        await _channelBeta.invokeMethod('stopListener', <String, dynamic>{});
    return isSet;
  }

  Future<bool> stopListenerGama() async {
    bool isSet =
        await _channelGama.invokeMethod('stopListener', <String, dynamic>{});
    return isSet;
  }

  Future<Map<String, dynamic>> getLocationAlpha(String id) async {
    Map<dynamic, dynamic> response = await _channelAlpha
        .invokeMethod('getLocation', <String, dynamic>{"id": id});

    Map<String, dynamic> location = new Map();

    response.forEach((key, value) {
      location[key] = value;
    });

    print(location);

    return location;
  }

  Future<Map<String, dynamic>> getLocationBeta(String id) async {
    Map<dynamic, dynamic> response = await _channelBeta
        .invokeMethod('getLocation', <String, dynamic>{"id": id});

    Map<String, dynamic> location = new Map();

    response.forEach((key, value) {
      location[key] = value;
    });

    print(location);

    return location;
  }

  Future<Map<String, dynamic>> getLocationGama(String id) async {
    Map<dynamic, dynamic> response = await _channelGama
        .invokeMethod('getLocation', <String, dynamic>{"id": id});

    Map<String, dynamic> location = new Map();

    response.forEach((key, value) {
      location[key] = value;
    });

    print(location);

    return location;
  }

  Stream<dynamic> queryAtLocationAlpha(double lat, double lng, double radius) {
    _channelAlpha.invokeMethod('queryAtLocation',
        {"lat": lat, "lng": lng, "radius": radius}).then((result) {
      print("result" + result);
    }).catchError((error) {
      print("Error " + error);
    });

    if (_queryAtLocationAlpha == null) {
      _queryAtLocationAlpha = _streamAlpha.receiveBroadcastStream();
    }
    return _queryAtLocationAlpha;
  }

  Stream<dynamic> queryAtLocationBeta(double lat, double lng, double radius) {
    _channelBeta.invokeMethod('queryAtLocation',
        {"lat": lat, "lng": lng, "radius": radius}).then((result) {
      print("result" + result);
    }).catchError((error) {
      print("Error " + error);
    });

    if (_queryAtLocationBeta == null) {
      _queryAtLocationBeta = _streamBeta.receiveBroadcastStream();
    }
    return _queryAtLocationBeta;
  }

  Stream<dynamic> queryAtLocationGama(double lat, double lng, double radius) {
    _channelGama.invokeMethod('queryAtLocation',
        {"lat": lat, "lng": lng, "radius": radius}).then((result) {
      print("result" + result);
    }).catchError((error) {
      print("Error " + error);
    });

    if (_queryAtLocationGama == null) {
      _queryAtLocationGama = _streamGama.receiveBroadcastStream();
    }
    return _queryAtLocationGama;
  }

  /*
  Update the query with the specified lat/lng and radius without the need to re-start the listner.
  */
  Future<bool> updateQueryAlpha(
      double latitude, double longitude, double radius) async {
    bool isSet = await _channelAlpha.invokeMethod('updateQuery',
        <String, dynamic>{"lat": latitude, "lng": longitude, "radius": radius});
    return isSet;
  }

  Future<bool> updateQueryBeta(
      double latitude, double longitude, double radius) async {
    bool isSet = await _channelBeta.invokeMethod('updateQuery',
        <String, dynamic>{"lat": latitude, "lng": longitude, "radius": radius});
    return isSet;
  }

  Future<bool> updateQueryGama(
      double latitude, double longitude, double radius) async {
    bool isSet = await _channelGama.invokeMethod('updateQuery',
        <String, dynamic>{"lat": latitude, "lng": longitude, "radius": radius});
    return isSet;
  }
}
