import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final Map rates;
  final Map priceChange;
  const Details({required this.rates, required this.priceChange});
  @override
  Widget build(BuildContext context) {
    List currencies = rates.keys.toList();
    List exchangeRates = rates.values.toList();
    List priceChangeCurrencies = priceChange.values.toList();
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
              String change = priceChangeCurrencies[index].toString();
              return ListTile(
                title: Text(
                  "$currency : $exchange",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),
                subtitle: Text(
                  "$change %",
                  style: const TextStyle(color: Colors.white54),
                ),
              );
            }),
      ),
    );
  }
}
