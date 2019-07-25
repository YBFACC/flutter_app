import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/model/home_model.dart';
import 'package:flutter_app/model/travel_tab_model.dart';
import 'package:http/http.dart' as http;

class TravelTabDao {
  static Future<TravelTabModel> fetch() async {
    final response = await http
        .get('http://www.devio.org/io/flutter_app/json/travel_page.json');
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); //中文
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelTabModel.fromJson(result);
    } else {
      throw Exception('travel_tab_page.json');
    }
  }
}
///////////////////////////
