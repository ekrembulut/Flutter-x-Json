import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_veriokuma/models/ordekler.dart';

class LocalJason extends StatefulWidget {
  LocalJason({Key? key}) : super(key: key);

  @override
  State<LocalJason> createState() => _LocalJasonState();
}

class _LocalJasonState extends State<LocalJason> {
  Color myColor = Colors.amber;
  late Future<List<Ordek>> futureList;
  bool renkDuzeni = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureList = jsonVeriGetir2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local Json"),
        backgroundColor: myColor,
      ),
      body: FutureBuilder<List<Ordek>>(
        future: futureList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Ordek> myData = snapshot.data!;
            return ListView.builder(
                itemCount: myData.length,
                itemBuilder: ((context, index) {
                  Ordek myIndex = myData[index];
                  return ListTile(
                    leading: Text(myIndex.ordekBoyu),
                    title: Text(myIndex.ordekTuru),
                    subtitle: Text(myIndex.ordekSulalesi.toString()),
                  );
                }));
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.hasError.toString()),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          setState(() {
            renkDuzeni = !renkDuzeni;
            myColor = renkDuzeni ? Colors.red : Colors.amber;
          });
        }),
      ),
    );
  }

  Future<List<Ordek>> jsonVeriGetir2() async {
    try {
      debugPrint('5 saniyelik işlem başlıyor');
      await Future.delayed(const Duration(seconds: 5), () {
        debugPrint('5 saniyelik işlem bitti');
      });
      String gelenJson = await DefaultAssetBundle.of(context)
          .loadString("assets/data/ordekler.json");
      var jsonObject = jsonDecode(gelenJson);
      List<Ordek> gelenListe =
          (jsonObject as List).map((e) => Ordek.fromMap(e)).toList();
      return gelenListe;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
