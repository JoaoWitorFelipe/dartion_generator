import 'dart:convert';

import 'package:http/http.dart' as http;

const String BASE_URL = 'http://localhost:3031';

abstract class IHttp {
  Future<String> get(String uri);
  Future<String> post(String uri, Map<String, dynamic> data);
}

class ClientHttp implements IHttp {
  final client = http.Client();

  Future<String> get(String uri) async {
    final response = await client.get(Uri.parse("$BASE_URL/$uri"));
    return response.body;
  }

  @override
  Future<String> post(String uri, Map<String, dynamic> data) async {
    final response = await client.post(
      Uri.parse("$BASE_URL/$uri"),
      body: jsonEncode(data),
      headers: {"content-type": "application/json"},
    );
    return response.body;
  }
}
