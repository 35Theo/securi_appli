import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RequestGit {
  String apikey = "Bearer: glpat-ACRWgcMgmqMHFC-KJAJQ";

  //Method GET
  Future<http.Response> materialToList() async {
    final response = await http.get(
      Uri(
          host: 'gitlab.com',
          scheme: 'https',
          path:
              'api/v4/projects/31979586/repository/files/assets%2Fliste%2Etxt'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': apikey
      },
    );
    return response;
  }

  //Method PUT
  Future<http.Response> addMaterialToList(
      String responseBody, String equipment) async {
    final response = await http.put(
      Uri(
          host: 'gitlab.com',
          scheme: 'https',
          path:
              'api/v4/projects/31979586/repository/files/assets%2Fliste%2Etxt'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': apikey
      },
      body: jsonEncode(<String, String>{
        "branch": "main",
        "content": "$responseBody , $equipment",
        "commit_message": "add ${equipment.split(" ")[0]}"
      }),
    );
    return response;
  }
}
