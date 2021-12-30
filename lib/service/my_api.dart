import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CallApi {
  final String base_url = 'http://ec2-3-17-24-2.us-east-2.compute.amazonaws.com:9990/';
  var token;

  getDataWithToken(apiUrl) async {
    var fullUrl = base_url + apiUrl;
    await _getToken();
    return await http.get(Uri.parse(fullUrl), headers: _setHeadersWithToken());
  }

  postData(data, apiUrl) async {
    var fullUrl = base_url + apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeadersWithToken());
  }

  postGetDataWithToken(data, apiUrl) async {
    var fullUrl = base_url + apiUrl;
    await _getToken();
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeadersWithToken());
  }

  getDataParameterWithToken(apiUrl, param) async {
    var fullUrl = base_url + apiUrl + param;
    await _getToken();
    return await http.get(Uri.parse(fullUrl), headers: _setHeadersWithToken());
  }

  _setHeadersWithToken() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
  }

  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  getData(apiUrl) async {
    var fullUrl = base_url + apiUrl;
    await _getToken();
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }

  postGetData(data, apiUrl) async {
    var fullUrl = base_url + apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  getNewsWithCategoryName(apiUrl, category_name) async {
    var fullUrl = base_url + apiUrl + category_name;
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }
}
