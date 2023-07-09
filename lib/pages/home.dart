import 'dart:convert';
import 'package:crpto_trackr/models/http.dart';
import 'package:crpto_trackr/pages/details.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  late double deviceHeight, deviceWidth;
  HttpService? http;
  String currentCoin = "bitcoin";

  @override
  void initState() {
    super.initState();
    http = GetIt.instance.get<HttpService>();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            coinDropdown(),
            _coinDetails(),
          ],
        ),
      ),
    ));
  }

  Widget coinDropdown() {
    // return FutureBuilder(
    // future: Dio().get("/coins/list"),
    // builder: ((context, snapshot) {
    // if (snapshot.hasData) {
    // Map coinList = jsonDecode(snapshot.data.toString());
    List<String> coins = [
      "bitcoin",
      "ethereum",
      "tether",
      "solana",
      "dogecoin"
    ];
    // coins.addAll(coinList["name"]);
    // print(coins);
    List<DropdownMenuItem> items = coins
        .map((e) => DropdownMenuItem(
            value: e,
            child: Text(
              e,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            )))
        .toList();
    return DropdownButton(
      items: items,
      onChanged: (current) {
        setState(() {
          currentCoin = current;
        });
      },
      value: currentCoin,
      dropdownColor: const Color(0xff4836b9),
      iconSize: 30,
      icon: const Icon(
        Icons.arrow_drop_down_sharp,
        color: Color(0xffD4D4D4),
      ),
      underline: Container(),
    );
    // } else {
    //   return const CircularProgressIndicator(
    //     color: Colors.white70,
    //   );
    // }
    // }),
    // );
  }

  Widget _coinDetails() {
    return FutureBuilder(
      future: http!.get("/coins/$currentCoin"),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map data = jsonDecode(snapshot.data.toString());
          num inr = data["market_data"]["current_price"]["inr"];
          num change = data["market_data"]["price_change_percentage_24h"];
          Map priceChange = data["market_data"]["price_change_24h_in_currency"];
          Map rates = data["market_data"]["current_price"];
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _coinImage(data["image"]["large"], rates, priceChange),
              _currentPrice(inr),
              _percentageChange(change),
              _coinDescription(data["description"]["en"])
            ],
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.white70,
          ));
        }
      },
    );
  }

  Widget _currentPrice(num rate) {
    return Text(
      "${rate.toStringAsFixed(2)} INR",
      style: const TextStyle(
          fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white70),
    );
  }

  Widget _percentageChange(num change) {
    return Text(
      "${change.toStringAsFixed(2)} %",
      style: const TextStyle(
          fontSize: 18, color: Colors.white70, fontWeight: FontWeight.w400),
    );
  }

  Widget _coinImage(String imageURL, Map rates, Map priceChange) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return Details(
            rates: rates,
            priceChange: priceChange,
          );
        }));
      },
      child: Container(
        height: deviceHeight * 0.20,
        width: deviceWidth * 0.20,
        padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.05),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageURL),
          ),
        ),
      ),
    );
  }

  Widget _coinDescription(String des) {
    return Container(
      height: deviceHeight * 0.45,
      width: deviceWidth * 0.90,
      margin: EdgeInsets.symmetric(
        vertical: deviceHeight * 0.05,
      ),
      padding: EdgeInsets.symmetric(
        vertical: deviceHeight * 0.01,
        horizontal: deviceHeight * 0.01,
      ),
      child: SingleChildScrollView(
        child: Text(
          des,
          style: const TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
