import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PriceData {
  getData(String selectedCurrency, String selectedCoin) async {
    http.Response response = await http.get(Uri.parse(
        "https://rest.coinapi.io/v1/exchangerate/$selectedCoin/$selectedCurrency?apikey=F99163BD-99EB-4A87-808C-4FB9AFAA1571"));
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = json.decode(data);
      return decodedData['rate'];
    } else {
      debugPrint("${response.statusCode}");
    }
  }
}
