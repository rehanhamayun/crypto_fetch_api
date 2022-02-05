import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class CryptoLive extends StatelessWidget {
  btcData() async {
    var btc =
        await Uri.parse("https://api.coinbase.com/v2/prices/spot?currency=USD");
    var response = await http.get(btc);
    var responseFinal = await json.decode(response.body)['data'];
    return responseFinal;
    //print(responseFinal);
    // flutter: {base: BTC, currency: USD, amount: 40698.14}
  }

  @override
  Widget build(BuildContext context) {
    btcData();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: Text(
          "BITCOIN HISTORY",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: FutureBuilder(
          future: btcData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              return Card(
                shadowColor: Color(0xFFFFFFF),
                margin: EdgeInsets.all(30),
                // color: Colors.grey.withOpacity(0.3),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(30, 20, 0, 20),
                        child: Image.network(
                            "https://freepngimg.com/thumb/bitcoin/59783-cryptocurrency-money-blockchain-bitcoin-cash-free-transparent-image-hq-thumb.png"),
                        height: 90,
                        width: 90,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                snapshot.data['base'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data['amount'] + "\$",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
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
