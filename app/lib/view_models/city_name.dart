import 'package:flutter/cupertino.dart';

import '../api/models.dart';
import '../api/service.dart';

//String selectedCity = 'Ankara';

class CityName extends ChangeNotifier {
  late Api api;
  String selectedCity = 'Ankara';
  String selectedTown = "";
  static bool citySelectionStatus = false;
  CityName(this.api);

  void setSelectedCity(String name) {
    api.getCityDressers(name);
    selectedCity = name;
    citySelectionStatus = true;
    api.getTown(name);
    notifyListeners();
  }

  getFirstCityName() {
    return api.dropCity!.length > 0 ? api.dropCity![0] : 'Ankara';
  }

  getFilteredCount() {
    return api.allHairDressersFiltered?.length;
  }

  getFilteredCities() {
    return api.allHairDressersFiltered;
  }

  void kiyasla(String data) {
    if (data == "fiyat") {
      Comparator<Features> siralama =
          (x, y) => x.properties!.fiyat!.compareTo(y.properties!.fiyat!);
      api.allHairDressersFiltered!.sort(siralama);

      notifyListeners();
    } else if (data == "Puan") {
      Comparator<Features> siralama =
          (y, x) => x.properties!.puan!.compareTo(y.properties!.puan!);
      api.allHairDressersFiltered!.sort(siralama);
      notifyListeners();
    }
  }

  void getTownDressers(String town) {
    selectedTown = town;

    api.getTownDressers(town, selectedCity);

    notifyListeners();
  }

  getFirstTownName() {
    return api.dropTown!.length > 0 ? api.dropTown![0] : 'Çankaya';
  }

  getSelectedCityTowns() {
    return api.getTown(selectedCity);
  }
}
