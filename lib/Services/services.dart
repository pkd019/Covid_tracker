import 'dart:convert';

import 'package:covid_tracker/Services/appurl.dart';
import 'package:http/http.dart' as http;

import '../model/WorldModel.dart';

class Service {
  Future<WorldModel> fetchworldrecord() async {
    final response = await http.get(Uri.parse(appUrl.world));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldModel.fromJson(data);
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> fetchcountry() async {
    final response = await http.get(Uri.parse(appUrl.country));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('error');
    }
  }
}
