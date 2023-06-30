import 'dart:convert';

import 'package:finance_flutter/offers/data/models/bank.dart';
import 'package:http/http.dart' as http;

class BankService {
  final String BANKS_ENDPOINT =
      "https://app-backend-finance-v2-230628160307.azurewebsites.net/api/v1/financial-entities";

  Future<List<Bank>> fetchAllBanks() async {
    http.Response response = await http.get(
      Uri.parse(BANKS_ENDPOINT),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return (json.decode(utf8.decode(response.bodyBytes))['content'] as List)
          .map((e) => Bank.fromJson(e))
          .toList();
    } else {
      return List.empty();
    }
  }
}
