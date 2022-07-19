import 'dart:convert';

import 'package:app/api/models.dart';
import 'package:http/http.dart' as http;

class Api {
  List<Features>? allHairDressersFiltered = [];
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
      allHairDressersFiltered = kuaforData.data?.features;

      return allHairDressersFiltered;
    } catch (e) {
      print('Bir hata oluştu:${e.toString()}');
    }
  }

  Future<List<String?>> getCity() async {
    List<String?> dropCityEmpty = [];
    for (i = 0; i < allHairDressers!.length; i++) {
      String? city = await allHairDressers![i].properties!.il;
      if (dropCityEmpty.indexOf(city) == -1) {
        dropCityEmpty.add(city);
      }
    }
    dropCityEmpty.sort();
    dropCity = dropCityEmpty;
    return dropCity;
  }

  Future<List<Features>?> getCityDressers(String? city) async {
    List<Features> filterCityEmpty = [];
    for (i = 0; i < allHairDressers!.length; i++) {
      String? cityArray = await allHairDressers![i].properties!.il;
      if (city == cityArray) {
        filterCityEmpty.add(allHairDressers![i]);
      }
    }
    allHairDressersFiltered = filterCityEmpty;

    return allHairDressersFiltered;
  }

  /*void kiyasla(String data) {
    if (data == "fiyat") {
      Comparator<Features> siralama =
          (x, y) => x.properties!.fiyat!.compareTo(y.properties!.fiyat!);
      allHairDressers?.sort(siralama);

      notifyListeners();
    } else if (data == "Puan") {
      Comparator<Features> siralama =
          (y, x) => x.properties!.puan!.compareTo(y.properties!.puan!);
      allHairDressers?.sort(siralama);
      notifyListeners();
    }
  }*/
}
