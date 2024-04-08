import 'dart:convert';
import 'package:flutter_memory_game/constants/values/url.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> postResult(Map body) async {
  const url = baseUrl + postResultEndpoint;

  try {
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      return null;
    }
  } catch (error) {
    // Handle any network or other errors
    return null;
  }
}
