import 'package:app/view_models/city_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_button_bar.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:provider/provider.dart';

import 'api/models.dart';
import 'api/service.dart';
import 'map-view.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Api api = new Api();

  bool functionComplete = false;

  void runParse() async {
    await api.jsonParse();
    setState(() {
      functionComplete = true;
    });
  }

  @override
  void initState() {
    runParse();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return functionComplete == false
        ? SizedBox()
        : Scaffold(
            appBar: AppBar(
              title: Text(''),
            ),
            body: Center(
              child: ChangeNotifierProvider(
                create: (context) => CityName(api),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: ExpansionTile(
                          title: Text("Sıralama"),
                          children: [
                            ListTile(
                              title: Text("Fiyata Göre"),
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text("Puana Göre"),
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text("Yakınlığa Göre"),
                              onTap: () {},
                            ),
                          ],
                        )),
                        Consumer<CityName>(
                          builder: (context, cityName, child) {
                            return DropdownButton<String>(
                              value: cityName.getFirstCityName(),
                              hint: Text("Lütfen Bir İl Seçiniz"),
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              items: api
                                  .getCity()
                                  .map<DropdownMenuItem<String>>(
                                      (String? value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text("$value"),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                cityName.setSelectedCity(newValue!);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    Consumer<CityName>(
                        builder: (BuildContext context, cityName, child) {
                      if (CityName.citySelectionStatus == true) {
                        return DropdownButton<String>(
                          value: cityName.getFirstTownName(),
                          hint: Text("Bir ilçe seçiniz"),
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          items: cityName
                              .getSelectedCityTowns()
                              .map<DropdownMenuItem<String>>((String? value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text("$value"),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            cityName.getTownDressers(newValue!);
                          },
                        );
                      } else {
                        return SizedBox();
                      }
                    }),
                    Consumer<CityName>(builder: (context, cityName, child) {
                      return Expanded(
                        child: ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: cityName.getFilteredCount(),
                            itemBuilder: (contex, index) {
                              List<Features> filteredItems =
                                  cityName.getFilteredCities();
                              return GFCard(
                                boxFit: BoxFit.cover,
                                showImage: true,
                                image: Image.asset('assets/barber.jpg'),
                                title: GFListTile(
                                  onTap: () {},
                                  titleText: filteredItems[index]
                                      .properties
                                      ?.adi
                                      .toString(),
                                  subTitleText:
                                      "Fiyat:${filteredItems[index].properties?.fiyat.toString()}",
                                ),
                                content: SizedBox(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Puan: ${filteredItems[index].properties?.puan.toString()}",
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "İl : ${filteredItems[index].properties?.il.toString()} - İlce : ${filteredItems![index].properties?.ilce.toString()}")
                                    ],
                                  ),
                                ),
                                buttonBar: GFButtonBar(
                                  children: <Widget>[
                                    GFButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NewPage()));
                                      },
                                      text: 'Haritada Göster',
                                      size: 50,
                                      color: Colors.teal,
                                      buttonBoxShadow: true,
                                      splashColor: Colors.amber,
                                    ),
                                    SizedBox(width: 100),
                                    GFButton(
                                      onPressed: () {},
                                      text: 'Navigasyon Aç',
                                      size: 50,
                                      color: Colors.teal,
                                      buttonBoxShadow: true,
                                      splashColor: Colors.amber,
                                    ),
                                  ],
                                ),
                              );
                            }),
                      );
                    }),
                  ],
                ),
              ),
            ),
          );
  }
}
