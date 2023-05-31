import 'dart:convert';

import 'package:http/http.dart' as http;

String baseUrl = "http://10.0.2.2:3000/api/locations/getLocations";

getDataLocations() async {
  Uri fullUrl = Uri.parse(baseUrl);

  final response = await http.get(fullUrl);

  return await jsonDecode(response.body)["data"];
}

postDataLocations(locationData) async {
  Uri fullUrl = Uri.parse(baseUrl);

  final response = await http.post(
    fullUrl,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'locations': locationData}),
  );

  return response;
}
