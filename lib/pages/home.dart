import 'dart:ui';

import 'package:crpto_trackr/models/http.dart';
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
          children: [coinDropdown()],
        ),
      ),
    ));
  }

  Widget coinDropdown() {
    List<String> coins = ["bitcoin"];
    List<DropdownMenuItem> items = coins
        .map((e) => DropdownMenuItem(
            value: e,
            child: Text(
              e,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            )))
        .toList();
    return DropdownButton(
      value: coins.first,
      items: items,
      onChanged: (value) {},
      dropdownColor: const Color(0xffD4D4D4),
      iconSize: 30,
      icon: const Icon(
        Icons.arrow_drop_down_sharp,
        color: Color(0xffD4D4D4),
      ),
      underline: Container(),
    );
  }
}
