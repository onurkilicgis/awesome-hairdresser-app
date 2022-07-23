import 'dart:convert';

import 'package:app/api/models.dart';
import 'package:http/http.dart' as http;

class Api {
  List<Features>? allHairDressersFiltered = [];
  List<Features>? allHairDressers = [];
  List<String?> dropCity = [];
  List<String?> dropTown = [];
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

  List<String?> getCity() {
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

  List<Features>? getCityDressers(String? city) {
    List<Features> filterCityEmpty = [];

    for (i = 0; i < allHairDressers!.length; i++) {
      String? cityArray = allHairDressers![i].properties!.il;
      if (city == cityArray) {
        filterCityEmpty.add(allHairDressers![i]);
      }
    }
    allHairDressersFiltered = filterCityEmpty;

    return allHairDressersFiltered;
  }

  List<Features>? getTownDressers(String? town, String? city) {
    List<Features> filterTownEmpty = [];
    for (i = 0; i < allHairDressers!.length; i++) {
      String? cityList = allHairDressers![i].properties!.il;
      String? townList = allHairDressers![i].properties!.ilce;
      if (city == cityList && town == townList) {
        filterTownEmpty.add(allHairDressers![i]);
      }
    }
    allHairDressersFiltered = filterTownEmpty;

    return allHairDressersFiltered;
  }

  List<String?> getTown(String cityname) {
    List<String?> dropTownEmpty = [];

    for (i = 0; i < allHairDressers!.length; i++) {
      String? town = allHairDressers![i].properties!.ilce;
      String? city = allHairDressers![i].properties!.il;

      if (dropTownEmpty.indexOf(town) == -1 && city == cityname) {
        dropTownEmpty.add(town);
      }
    }
    dropTownEmpty.sort();
    dropTown = dropTownEmpty;
    return dropTown;
  }
}
