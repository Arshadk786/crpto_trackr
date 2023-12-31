import 'dart:convert';
import 'package:crpto_trackr/models/app_api.dart';
import 'package:crpto_trackr/models/http.dart';
import 'package:flutter/material.dart';
import 'package:crpto_trackr/pages/home.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadContent();
  registerHTTP();
  await GetIt.instance.get<HttpService>().get("/coins/bitcoin");
  runApp(const MyApp());
}

Future<void> loadContent() async {
  String content = await rootBundle.loadString("assets/config/main.json");
  Map apiData = jsonDecode(content);
  GetIt.instance
      .registerSingleton<Api>(Api(apiUrl: apiData["COIN_GECKO_API_URL"]));
}

void registerHTTP() {
  GetIt.instance.registerSingleton<HttpService>(
    HttpService(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoTrackr',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: const Color(0xff4836b9),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
