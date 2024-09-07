import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/core/location_utils/location_utils.dart';

class SelectLocationView extends StatefulWidget {
  const SelectLocationView({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  final void Function(LatLng v) onSelected;

  @override
  State<SelectLocationView> createState() => _SelectLocationViewState();
}

class _SelectLocationViewState extends State<SelectLocationView> {
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LocationUtils.currentLocation,
                zoom: 16,
              ),
              myLocationEnabled: true,
              markers: markers,
              onTap: (v) {
                markers.add(
                  Marker(
                    markerId: MarkerId("location"),
                    position: v,
                  ),
                );
                setState(() {});
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SafeArea(
              child: ElevatedButton(
                onPressed: markers.isEmpty ? null : () {
                  Navigator.pop(context);
                  widget.onSelected(markers.first.position);
                },
                child: Text('Confirm'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
