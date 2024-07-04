
import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_api/Model/google_model.dart';
import 'package:google_maps_api/Model/search_model.dart';
import 'package:google_maps_api/Services/services.dart';

class ApiController extends GetxController {
  final ApiService _apiService = ApiService();
  Rx<Google> googleData = Rx<Google>(Google(restaurants: [], event: []));
  Rx<Search> searchData = Rx<Search>(Search(searchData: []));
  RxList<SearchDatum> searchSuggestions = RxList<SearchDatum>();

  final Completer<GoogleMapController> mapController = Completer();

  @override
  void onInit() {
    fetchGoogleData();
    super.onInit();
  }

  void fetchGoogleData() async {
    try {
      var data = await _apiService.fetchDataFromCustomApi();
      googleData.value = Google.fromJson(data);
    } catch (e) {
      print("Error fetching Google data: $e");
    }
  }

  void fetchSearchData(String query) async {
    try {
      var data = await _apiService.fetchSearchData(query);
      searchData.value = data;
      fetchSearchSuggestions(query);
    } catch (e) {
      print("Error fetching Search data: $e");
    }
  }

  void fetchSearchSuggestions(String query) {
    if (query.isEmpty) {
      searchSuggestions.close();
      searchSuggestions.clear();
      return;
    }
    List<SearchDatum> filteredList = searchData.value.searchData
        .where((datum) => datum.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    searchSuggestions.assignAll(filteredList);
  }
}
