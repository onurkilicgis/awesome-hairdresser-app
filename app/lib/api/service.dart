import 'dart:convert';

import 'package:app/api/models.dart';
import 'package:http/http.dart' as http;

class Api {
  List<Features>? allHairDressers = [];
  List<String?> dropCity = [];
  late int i;

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

  getCity() {
    List<String?> dropCityEmpty = [];
    for (i = 0; i < allHairDressers!.length; i++) {
      String? city = allHairDressers![i].properties!.il;
      if (dropCityEmpty.indexOf(city) == -1) {
        dropCityEmpty.add(city);
      }
    }
    dropCityEmpty.sort();
    dropCity = dropCityEmpty;
    return dropCity;
  }
}
