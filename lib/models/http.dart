import 'package:dio/dio.dart';
import 'app_api.dart';
import 'package:get_it/get_it.dart';

class HttpService {
  final Dio dio = Dio();
  Api? api;
  String? baseUrl;

  HttpService() {
    api = GetIt.instance.get<Api>();
    baseUrl = api!.apiUrl;
  }

  Future<Response?> get(String path) async {
    try {
      String url = "$baseUrl$path";
      Response response = await dio.get(url);
      print(response);
      return response;
    } catch (e) {
      print(e);
    }
  }
}
