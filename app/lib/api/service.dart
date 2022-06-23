import 'dart:convert';

import 'package:app/api/models.dart';
import 'package:http/http.dart' as http;

class Api {
  List<Features>? allHairDressers = [];

  Future<List<Features>?> jsonParse() async {
    try {
      final url = 'https://baklanyeni.baklanmeyvecilik.com/api/v1/kuaforler';
      final response = await http.get(Uri.parse(url));

      // if (response.statusCode == 201) {
      final data = jsonDecode(response.body);

      HairDressers kuaforData = HairDressers.fromJson(data);
      allHairDressers = kuaforData.data?.features;
      return allHairDressers;
    } catch (e) {
      print('Bir hata oluştu:${e.toString()}');
    }
  }
}
