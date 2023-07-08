import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final Map rates;
  final num change;
  const Details({required this.rates, required this.change});
  @override
  Widget build(BuildContext context) {
    List currencies = rates.keys.toList();
    List exchangeRates = rates.values.toList();
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
        body: ListView.builder(
            itemCount: currencies.length,
            itemBuilder: (context, index) {
              String currency = currencies[index].toString().toUpperCase();
              String exchange = exchangeRates[index].toString();
              return ListTile(
                title: Text(
                  "$currency : $exchange",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),
                subtitle: Text("$change %"),
              );
            }),
      ),
    );
  }
}
