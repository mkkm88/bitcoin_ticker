import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

const coinAPIURl = 'https://api.tatum.io/v4/data/rate/symbol';
const apiKey = 't-6918c6873b9bb09e10628df8-b7f96cd9589e4cadb404dd7d';

class CoinData {
  getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestUrl =
          '$coinAPIURl?symbol=$crypto&basePair=$selectedCurrency';

      var response = await http.get(
        Uri.parse(requestUrl),
        headers: {'x-api-key': apiKey},
      );
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var lastPrice = double.parse(decodedData['value'].toString());
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print('Status Code: ${response.statusCode}');
        print(response.body);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
