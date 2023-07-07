import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            size: 30,
            color: Colors.white70,
          ),
          backgroundColor: const Color(0xff4836b9),
          // title: const Icon(
          //   Icons.arrow_back_rounded,
          //   color: Colors.white70,
          //   size: 30,
        ),
      ),
    );
  }
}
