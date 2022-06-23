import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_button_bar.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

import 'api/models.dart';
import 'api/service.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Api api = new Api();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<List<Features>?>(
                future: api.jsonParse(),
                builder: (context, snapshot) {
                  if (snapshot.hasData != null) {
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: api.allHairDressers?.length,
                        itemBuilder: (contex, index) {
                          return GFCard(
                            boxFit: BoxFit.cover,
                            showImage: true,
                            image: Image.asset('assets/barber.jpg'),
                            title: GFListTile(
                              title: Text(''),
                            ),
                            content: SizedBox(
                              height: 45,
                              child: Text(''),
                            ),
                            buttonBar: GFButtonBar(
                              children: <Widget>[
                                GFButton(
                                  onPressed: () {},
                                  text: 'Satın Al',
                                  size: 67,
                                  color: Colors.green,
                                  buttonBoxShadow: true,
                                  splashColor: Colors.amber,
                                ),
                                SizedBox(width: 300),
                                GFButton(
                                  onPressed: () {},
                                  text: 'Paylaş',
                                  size: 67,
                                  color: Colors.green,
                                  buttonBoxShadow: true,
                                  splashColor: Colors.amber,
                                ),
                              ],
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Container(child: Text("veri bulunamadı"));
                  } else {
                    return Container(
                        child: Center(
                      child: CircularProgressIndicator(),
                    ));
                  }
                })
          ],
        ),
      ),
    );
  }
}
