import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:json_veriokuma/models/users.dart';

class JsonWeb extends StatefulWidget {
  JsonWeb({Key? key}) : super(key: key);

  @override
  State<JsonWeb> createState() => _JsonWebState();
}

class _JsonWebState extends State<JsonWeb> {
  late Future<List<User>> myData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myData = webJsonVeri();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Web Json Data")),
      body: FutureBuilder<List<User>>(
          future: myData,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              var userList = snapshot.data!;
              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: ((context, index) {
                var user = userList[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                );
              }));
            } else if (snapshot.hasError) {
              return Text(snapshot.hasError.toString());
            } else {
              return CircularProgressIndicator();
            }
          })),
    );
  }
}

Future<List<User>> webJsonVeri() async {
  try {
    var response =
        await Dio().get("https://jsonplaceholder.typicode.com/users");
    List<User> gelenVeri = [];
    if (response.statusCode == 200) {
      gelenVeri = (response.data as List).map((e) => User.fromMap(e)).toList();
    }
    return gelenVeri;
  } on DioError catch (e) {
    return Future.error(e.message);
  }
  ;
}
