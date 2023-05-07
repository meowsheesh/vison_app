import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:textocr/consts/prompt_consts.dart';
import 'package:textocr/models/models.dart';

import '../consts/api_consts.dart';

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(Uri.parse("$BASE_URL/models"),
          headers: {'Authorization': 'Bearer $API_KEY'});
      Map jsonResponse = jsonDecode(response.body);
      // print('Json response $jsonResponse');
      List temp = [];
      for (var value in jsonResponse['data']) {
        temp.add(value);
        print("temp ${value["id"]}");
      }
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (e) {
      print('error $e');
      rethrow;
    }
  }

  static Future<String> getAnswer(String message) async {
    try {
      var response = await http.post(Uri.parse("$BASE_URL/completions"),
          headers: {
            "Authorization": "Bearer $API_KEY",
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "model": "text-davinci-003",
            "prompt": "$shortAnswer $message",
            "max_tokens": 100,
          }));
      Map jsonResponse = jsonDecode(response.body);
      return jsonResponse["choices"][0]["text"];
    } catch (e, s) {
      print(e);
      print(s);
      rethrow;
    }
  }
}
