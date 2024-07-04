
import 'dart:convert';
import 'package:google_maps_api/Model/search_model.dart';
import 'package:http/http.dart' as http;
class ApiService {
  final String googleApiEndpoint =
      "Use you own api";
  final String searchApiEndpoint =
      "Use you own api";

  Future<Search> fetchSearchData(String query) async {
      final response = await http.post(
        Uri.parse(searchApiEndpoint),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'query': query}),
      );
      if (response.statusCode == 201 ) {
        return Search.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to load search data - Status Code: ${response.statusCode}');
      }
  }


  Future<Map<String, dynamic>> fetchDataFromCustomApi() async {
    try {
      var response = await http.get(
        Uri.parse(googleApiEndpoint),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Response body: ${response.body}');
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        print('Failed to load data - Status Code: ${response.statusCode}');
        //print('Response body: ${response.body}');
        throw Exception(
            'Failed to load data - Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data: $e');
    }
  }
}
