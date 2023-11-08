import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:core';
import 'dart:convert';

class GetModelFromApi {
  List<StockModel> stockModel = [];
  Future<List<StockModel>> getModel() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://latest-stock-price.p.rapidapi.com/price?Indices=NIFTY 50'),
        headers: {
          'X-RapidAPI-Host': 'latest-stock-price.p.rapidapi.com',
          'X-RapidAPI-Key':
              'b4080c9322msh0c4fb2c51b41812p1bac59jsn31f3a5f2b241',
        },
      );
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        for (Map i in data) {
          stockModel.add(StockModel.fromJson(i));
        }
        return stockModel;
      } else {
        log('Response Body: ${response.body}');
        return stockModel;
      }
    } catch (error) {
      log('Error: $error');
      return stockModel;
    }
  }
}

class StockModel {
  String? symbol;
  String? identifier;
  String? open;
  String? dayHigh;
  String? dayLow;
  String? lastPrice;
  String? previousClose;
  String? change;
  String? pChange;
  String? yearHigh;
  String? yearLow;
  String? totalTradedVolume;
  String? totalTradedValue;
  String? lastUpdateTime;
  String? perChange365d;
  String? perChange30d;

  StockModel(
      {this.symbol,
      this.identifier,
      this.open,
      this.dayHigh,
      this.dayLow,
      this.lastPrice,
      this.previousClose,
      this.change,
      this.pChange,
      this.yearHigh,
      this.yearLow,
      this.totalTradedVolume,
      this.totalTradedValue,
      this.lastUpdateTime,
      this.perChange365d,
      this.perChange30d});

  StockModel.fromJson(Map<dynamic, dynamic> json) {
    symbol = json['symbol']?.toString();
    identifier = json['identifier']?.toString();
    open = json['open']?.toString(); // Convert to double
    dayHigh = json['dayHigh']?.toString();
    dayLow = json['dayLow']?.toString();
    lastPrice = json['lastPrice']?.toString();
    previousClose = json['previousClose']?.toString();
    change = json['change']?.toString();
    pChange = json['pChange']?.toString();
    yearHigh = json['yearHigh']?.toString();
    yearLow = json['yearLow']?.toString();
    totalTradedVolume = json['totalTradedVolume']?.toString();
    totalTradedValue = json['totalTradedValue']?.toString();
    lastUpdateTime = json['lastUpdateTime']?.toString();
    perChange365d = json['perChange365d']?.toString();
    perChange30d = json['perChange30d']?.toString();
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['symbol'] = symbol;
    data['identifier'] = identifier;
    data['open'] = open;
    data['dayHigh'] = dayHigh;
    data['dayLow'] = dayLow;
    data['lastPrice'] = lastPrice;
    data['previousClose'] = previousClose;
    data['change'] = change;
    data['pChange'] = pChange;
    data['yearHigh'] = yearHigh;
    data['yearLow'] = yearLow;
    data['totalTradedVolume'] = totalTradedVolume;
    data['totalTradedValue'] = totalTradedValue;
    data['lastUpdateTime'] = lastUpdateTime;
    data['perChange365d'] = perChange365d;
    data['perChange30d'] = perChange30d;
    return data;
  }
}
