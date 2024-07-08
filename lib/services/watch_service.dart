import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/product.dart';
//import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://api.timbu.cloud/products';
  static const String organizationId = 'b667941d18a74843a373d9f220210b40';
  static const String appId = '8P994EADF87PSAG';
  static const String apiKey =
      '9adfbc71bb01405cab62632429b816be20240706130617811667';

  Future<List<Product>> fetchProducts() async {
    final String url =
        '$baseUrl?organization_id=$organizationId&Appid=$appId&Apikey=$apiKey';
    final Uri uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      print('Response status code: ${response.statusCode}');
      print('Response status code: ${response.body}');
      final mapResponse = json.decode(response.body);
      final listResponse = mapResponse['items'];
      return List<Product>.from(
          listResponse.map((item) => Product.fromJson(item)));
    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}'); //
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }
}
