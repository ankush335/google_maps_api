
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_api/Controller/controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiController apiController = Get.put(ApiController());
  TextEditingController _searchController = TextEditingController();
  Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.72732592325358, 76.69896270883605),
    zoom: 5,
  );
  Set<Marker> _markers = {};
  BitmapDescriptor? customIcon;

  @override
  void initState() {
    super.initState();
    apiController.fetchGoogleData();
    _loadCustomIcon();
    apiController.mapController.complete(_controller.future);
  }

  Future<void> _loadCustomIcon() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(100, 100)),
      'assets/icons/picker.png',
    );
    setState(() {}); // Rebuild the widget to reflect the change
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Google Map
          Obx(() {
            var data = apiController.googleData.value;
            _markers.clear();
            for (var restaurant in data.restaurants) {
              if (restaurant.latitude != null &&
                  restaurant.longitude != null &&
                  double.tryParse(restaurant.latitude!) != null &&
                  double.tryParse(restaurant.longitude!) != null) {
                _markers.add(Marker(
                  markerId: MarkerId(restaurant.id.toString()),
                  position: LatLng(
                    double.parse(restaurant.latitude!),
                    double.parse(restaurant.longitude!),
                  ),
                  infoWindow: InfoWindow(
                    title: restaurant.restaurantName,
                    snippet: 'Rating: ${restaurant.rating}',
                  ),
                  icon: customIcon ?? BitmapDescriptor.defaultMarker,
                ));
              }
            }

            return GoogleMap(
              initialCameraPosition: _kGooglePlex,
              mapType: MapType.normal,
              myLocationEnabled: true,
              compassEnabled: true,
              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            );
          }),

          // Search TextField and Suggestions List
          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: Column(
              children: <Widget>[
                // Search TextField
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    suffixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      apiController.fetchSearchData(value);
                    } else {
                      apiController.searchSuggestions.clear();
                    }
                  },
                ), // Search Suggestions List
                Obx(() {
                  var suggestions = apiController.searchSuggestions;
                  return suggestions.isNotEmpty
                      ? Container(
                                          color: Colors.white,
                                          constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height -150, // Adjust the max height as needed
                                          ),
                                          child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.grey, // Customize the color of the divider
                          thickness: 1, // Customize the thickness of the divider
                        );
                      },
                      shrinkWrap: true,
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        final suggestion = suggestions[index];
                        return ListTile(
                          leading: const Icon(Icons.place),
                          title: Text(suggestion.name ?? "No name"),
                          onTap: () {
                            print("suggestion is :${suggestion.name}");

                            // Move camera to the selected location
                            _searchController.clear();
                            apiController.searchSuggestions.clear();
                          },
                        );
                      },
                                          ),
                                        )
                      : Container();
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
