import 'dart:convert';
//import "package:get/get.dart";
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class UsersData extends StatelessWidget {
  userData() async {
    final userURL =
        await Uri.parse("https://jsonplaceholder.typicode.com/posts");

    var respone = await http.get(userURL);

    var finalize = json.decode(respone.body);
    return finalize;
  }

  @override
  Widget build(BuildContext context) {
    userData();
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        title: Text(
          "USERS DATA",
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: userData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Row(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.all(20),
                          height: 150,
                          //width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data[index]['id'].toString(),
                              ),
                              Text(
                                snapshot.data[40]['title'],
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                snapshot.data[index]['userId'].toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return Text("");
// THATS MAIN CIRCULER IN FUTURE BUILDER (we have to put snapshot if else data above)
          //return Center(
          //child: Text("Rehan"),
          //);
        },
      ),
    );
  }
}
