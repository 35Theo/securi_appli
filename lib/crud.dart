import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:securi_appli/request.dart';

class Equipments {
  final String nameEquipment;

  Equipments(this.nameEquipment);
  factory Equipments.fromJson(Map<String, dynamic> json) {
    return Equipments(
      json['nameEquipment'],
    );
  }
}

List<Equipments> parseEquipments(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Equipments>((json) => Equipments.fromJson(json)).toList();
}

Future<Equipments> fetchEquipments() async {
  final response = await http.get(
    Uri.parse(
        'https://gitlab.com/api/v4/projects/31979586/repository/files/assets%2Fliste%2Etxt/raw'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': "Bearer: glpat-ACRWgcMgmqMHFC-KJAJQ",
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Equipments.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load equipments');
  }
}
