import 'dart:convert';

import 'package:covid_tracker_app/models/World_stats_model.dart';
import 'package:covid_tracker_app/services/utils/app_urls.dart';
import 'package:http/http.dart' as http;

class StatsServices {
  //?? worlds stats ->
  Future<WorldStatsModel> fetchWorldStatsRecords() async {
    final response = await http.get(
      Uri.parse(ApiUrls.worldsStatsApi),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  //?? countries list ->
  Future<List<dynamic>> fetchCountriesListApi() async {
    var data;

    final response = await http.get(
      Uri.parse(ApiUrls.countryStatsApi),
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
