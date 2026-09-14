import 'dart:convert';

import 'package:corona_virus/Modal/Api_Modal.dart';
import 'package:corona_virus/Modal/services/api_url.dart';
import 'package:http/http.dart' as http;

class services {
  Future<stateData> fetchData() async {
    final response = await http.get(Uri.parse(AppUrl.WorldStatesApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return stateData.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }
}

class countries {
  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
