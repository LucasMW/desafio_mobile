import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter_map_location/flutter_map_location.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _currentPosition;
  Location location = Location();
  late bool _serviceEnabled;
  FlutterMap? daMap;
  MapController? mapController = MapController();

  Future<void> requestPermission() async {
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
  }

  void startLocationTacking() {
    location.onLocationChanged.listen((LocationData currentLocation) {
      final lat = currentLocation.latitude;
      final long = currentLocation.longitude;
      if (lat == null || long == null) return;
      final coords = LatLng(lat, long);
      print("update $coords");
      mapController?.move(_currentPosition ?? coords, mapController!.zoom);
      setState(() {
        _currentPosition = coords;
      });
    });
  }

  @override
  void initState() {
    requestPermission().then((value) => startLocationTacking());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locationOptions = LocationOptions(
      locationButton(),
      onLocationUpdate: (LatLngData? ld) {
        print('Location updated: ${ld?.location} (accuracy: ${ld?.accuracy})');
      },
      onLocationRequested: (LatLngData? ld) {
        if (ld == null) {
          return;
        }
        print(mapController);
        mapController?.move(ld.location, mapController?.zoom ?? 16);
      },
    );
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: _currentPosition,
        zoom: 13.0,
        plugins: <MapPlugin>[
          LocationPlugin(),
        ],
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
                width: 40.0,
                height: 40.0,
                point: _currentPosition ?? LatLng(51.5, -0.09),
                builder: (ctx) => Container(
                      decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.5),
                          shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.blue, shape: BoxShape.circle),
                        ),
                      ),
                    )),
          ],
        ),
      ],
      // nonRotatedLayers: <LayerOptions>[
      //   // USAGE NOTE 3: Add the options for the plugin
      //   locationOptions,
      // ],
    );

    return Scaffold(
      body: daMap,
    );
  }

  LocationButtonBuilder locationButton() {
    return (BuildContext context, ValueNotifier<LocationServiceStatus> status,
        Function onPressed) {
      return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
          child: FloatingActionButton(
              child: ValueListenableBuilder<LocationServiceStatus>(
                  valueListenable: status,
                  builder: (BuildContext context, LocationServiceStatus value,
                      Widget? child) {
                    switch (value) {
                      case LocationServiceStatus.disabled:
                      case LocationServiceStatus.permissionDenied:
                      case LocationServiceStatus.unsubscribed:
                        return const Icon(
                          Icons.location_disabled,
                          color: Colors.white,
                        );
                      default:
                        return const Icon(
                          Icons.location_searching,
                          color: Colors.white,
                        );
                    }
                  }),
              onPressed: () => onPressed()),
        ),
      );
    };
  }
}
