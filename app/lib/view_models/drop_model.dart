import 'package:flutter/cupertino.dart';

import '../api/service.dart';

class CityName extends ChangeNotifier {
  late Api api;
  CityName(this.api);

  String selectedCity = 'Cities';

  void setSelectedCity(String name) {
    api.getCityDressers(name);
    selectedCity = name;
    notifyListeners();
  }

  getFilteredCities() {
    return api.getCityDressers(selectedCity);
  }
}
