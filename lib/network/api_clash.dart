import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:clash_api/models/card_clash_model.dart';

class ApiClash {
  String token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6ImEwZDkwYzc2LTdmZWEtNDdmZC04NjdiLTUxYTkwZmQxN2Q4MCIsImlhdCI6MTY4MDE0MjgyMCwic3ViIjoiZGV2ZWxvcGVyL2VkOGQ1Y2IyLTVjNmEtYTVhNC01YTkzLWM3NTMxN2MwY2IyZiIsInNjb3BlcyI6WyJyb3lhbGUiXSwibGltaXRzIjpbeyJ0aWVyIjoiZGV2ZWxvcGVyL3NpbHZlciIsInR5cGUiOiJ0aHJvdHRsaW5nIn0seyJjaWRycyI6WyIxODcuMTkwLjIwMi4xNzkiXSwidHlwZSI6ImNsaWVudCJ9XX0.CjTqA-vSrPcV77SCGOi3hRbn1YA2Y1VrH-4S-vfqBVgaGxnDTCZKC4lm2xb7tcJAaZcipcZL6_xcAKkZzyMzfw';
  Uri link = Uri.parse('https://api.clashroyale.com/v1/cards?limit=10');
  Future<List<ClashCard>?> getAllCards() async {
    await Future.delayed(const Duration(seconds: 4)).then((_) => {});
    var result = await http.get(
      link,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (result.statusCode == 200) {
      var listJSON = jsonDecode(result.body)['items'] as List;
      return listJSON.map((card) => ClashCard.fromMap(card)).toList();
    } else {
      String jsonString = await _loadAsset();
      var listaux = jsonDecode(jsonString)['items'] as List;
      return listaux.map((card) => ClashCard.fromMap(card)).toList();
    }
  }

  Future<String> _loadAsset() async {
    return await rootBundle.loadString('assets/clash.json');
  }
}
