import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:json_veriokuma/models/posts.dart';

class JsonPost extends StatefulWidget {
  JsonPost({Key? key}) : super(key: key);

  @override
  State<JsonPost> createState() => _JsonPostState();
}

class _JsonPostState extends State<JsonPost> {
  late Future<List<Posts>> myData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myData = futurePosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Json Veri Posts")),
      body: FutureBuilder<List<Posts>>(
        future: myData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: ((context, index) {
                  var data1 = data[index];
                  return ListTile(
                    leading: Text(data1.id.toString()),
                    title: Text(data1.body),
                    subtitle: Text(data1.title),
                  );
                }));
          } else if (snapshot.hasError) {
            return Text(snapshot.hasError.toString());
          } else {
            return const Center(
              child: CircularProgressIndicator()
            );
          }
        },
      ),
    );
  }

  Future<List<Posts>> futurePosts() async {
    try {
      var postItems =
          await Dio().get("https://jsonplaceholder.typicode.com/posts");
      List<Posts> postListesi = [];
      if (postItems.statusCode == 200) {
        postListesi =
            (postItems.data as List).map((e) => Posts.fromMap(e)).toList();
      }
      return postListesi;
    } on DioError catch (e) {
      return Future.error(e.message);
    }
  }
}
