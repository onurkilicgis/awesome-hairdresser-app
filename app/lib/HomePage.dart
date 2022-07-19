import 'package:app/view_models/drop_model.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      api.jsonParse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: ChangeNotifierProvider(
          create: (BuildContext context) => CityName(api),
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
                  FutureBuilder(
                      future: api.getCity(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        return Consumer<CityName>(
                          builder: (context, cityName, child) {
                            return DropdownButton<String>(
                              value: cityName.selectedCity,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              items: api.dropCity.map<DropdownMenuItem<String>>(
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
                        );
                      })
                ],
              ),
              Consumer<CityName>(builder: (context, cityName, child) {
                return FutureBuilder<List<Features>?>(
                    future: cityName.getFilteredCities(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData != null) {
                        /*List<dynamic> array =
                            api.allHairDressers as List<Features>;*/
                        return Expanded(
                          child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length,
                              itemBuilder: (contex, index) {
                                return GFCard(
                                  boxFit: BoxFit.cover,
                                  showImage: true,
                                  image: Image.asset('assets/barber.jpg'),
                                  title: GFListTile(
                                    onTap: () {},
                                    titleText: snapshot
                                        .data![index].properties?.adi
                                        .toString(),
                                    subTitleText:
                                        "Fiyat:${snapshot.data![index].properties?.fiyat.toString()}",
                                  ),
                                  content: SizedBox(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Puan: ${snapshot.data![index].properties?.puan.toString()}",
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            "Adres:${snapshot.data![index].properties?.il.toString()}${snapshot.data![index].properties?.ilce.toString()}")
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
                      } else if (snapshot.hasError) {
                        return Container(child: Text("veri bulunamadı"));
                      } else {
                        return Container(
                            child: Center(
                          child: CircularProgressIndicator(),
                        ));
                      }
                    });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
