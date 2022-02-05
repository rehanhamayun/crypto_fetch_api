import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Ethereum extends StatelessWidget {
  ethData() async {
    var eth =
        await Uri.parse("https://api.coinbase.com/v2/prices/ETH-USD/spot");
    var response = await http.get(eth);
    var ethFinal = await json.decode(response.body)['data'];
    return ethFinal;
    //{"data":{"base":"ETH","currency":"USD","amount":"3254.6"}}
  }

  @override
  Widget build(BuildContext context) {
    ethData();
    return Scaffold(
      body: FutureBuilder(
          future: ethData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return Card(
                child: Container(
                  margin: EdgeInsets.only(top: 200),
                  height: 200,
                  width: double.infinity,
                  //color: Colors.red,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35,
                      ),
                      Container(
                        child: Image.network(
                            "https://img.search.brave.com/dSac8AM_XGVm0I5vbETQXog28B_SSVT6WRmDxs0sUuc/rs:fit:1146:225:1/g:ce/aHR0cHM6Ly90c2U0/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC50/c1FRbk9vX2hZUnln/RFFvSXlzTXl3SGFE/RSZwaWQ9QXBp"),
                        height: 200,
                        width: 200,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data['base'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21),
                            ),
                            Text(
                              snapshot.data['amount'] + "\$",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Text("");
          }),
    );
  }
}
