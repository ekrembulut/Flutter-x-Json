import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_veriokuma/jsonAlbum.dart';
import 'package:json_veriokuma/jsonFromWeb.dart';
import 'package:json_veriokuma/jsonPosts.dart';
import 'package:json_veriokuma/localJson.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Json Veri Okuma"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: TextButton(
            child: Text("Json Veri Getir"),
            onPressed: () {
              jsonVeriGetir();
            },
          )),
          Center(
              child: TextButton(
            child: Text("Json Veri Getir 2 "),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => LocalJason())));
            },
          )),
          Center(
              child: TextButton(
            child: Text("Json Data From Web "),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => JsonWeb())));
            },
          )),
          Center(
              child: TextButton(
            child: Text("Json Data From Post "),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => JsonPost())));
            },
          )),
          Center(
              child: TextButton(
            child: Text("Json Data From Album "),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => JsonAlbum())));
            },
          )),
        ],
      ),
    );
  }

  jsonVeriGetir() async {
    String okunanString = await DefaultAssetBundle.of(context)
        .loadString("assets/data/ordekler.json");
    var jsonOnject = jsonDecode(okunanString);
    debugPrint(okunanString);
    debugPrint("*********");
    List okunanListe = jsonOnject;
    print(okunanListe[0]["ordek_sulalesi"][0]["dede_adi"].toString());
  }

  
}
