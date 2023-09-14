import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class AppApi {
  static Future<dynamic> apiGetRequest(String _url) async {
    Uri url = Uri.parse(_url);
    var response = await http.get(url); 
    var xx = json.decode(response.body);
    return xx;
  }

  static Future<dynamic> apiPostRequest(String _url, json) async {
    Uri url = Uri.parse(_url);
    var response = await http.post(url, body: json);
    var xx = json.decode(response.body);
    return xx;
  }

  static Future<dynamic> get(String url) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    var jsonResponse = json.decode(reply);
    return jsonResponse;
  }

  static Future<dynamic> post(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    print(reply);
    var jsonResponse = json.decode(reply);
    return jsonResponse;
  }
  static Future<dynamic> post2(String _url, Map jsonData) async {
    Uri url = Uri.parse(_url);
    var response = await http.post(url, body: jsonData);
    var xx = json.decode(response.body);
    return xx;
  }

  static Future<dynamic> postWithMap(
      String _url, Map<String, dynamic> jsonMap) async {
    Uri url = Uri.parse(_url);
    var jsonData = jsonEncode(jsonMap);
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonData);
    var xx = jsonDecode(response.body);
    print(xx);
    return xx;
  }

  static Future<dynamic> post_Json(String _url, Map jsonMap) async {
    Uri url = Uri.parse(_url);
    var jsonData = utf8.encode(json.encode(jsonMap));
    var response = await http.post(url,
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "charset":"UTF-8",
        },
        body: jsonData);
    var xx = jsonDecode(utf8.decode(response.bodyBytes).toString().replaceAll("\n", ""));
    return xx;
  }
  static Future<dynamic> post_String(String _url, Map jsonMap) async {
    Uri url = Uri.parse(_url);
    var jsonData = utf8.encode(json.encode(jsonMap));
    var response = await http.post(url,
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
        },
        body: jsonData);
    var xx = response.body;
    return xx;
  }

  static Future<dynamic> http_delete(String _url) async {
    Uri url = Uri.parse(_url);
    var response = await http.delete(url);
    var xx = json.decode(response.body);
    return xx;
  }
}
