import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WatchListScreen extends StatefulWidget {
  @override
  _WatchListScreenState createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  List<Map<String, dynamic>> watches = [];

  @override
  void initState() {
    super.initState();
    fetchWatches();
  }

  Future<void> fetchWatches() async {
    final String baseUrl = 'https://api.timbu.cloud/products';
    final String organizationId = 'b667941d18a74843a373d9f220210b40';
    final String appId = '8P994EADF87PSAG';
    final String apiKey =
        '9adfbc71bb01405cab62632429b816be20240706130617811667';

    final String url =
        '$baseUrl?organization_id=$organizationId&Appid=$appId&Apikey=$apiKey';

    final Uri uri = Uri.parse(url);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final mapResponse = json.decode(response.body);
      final listResponse = mapResponse['items'];

      setState(() {
        watches = List<Map<String, dynamic>>.from(listResponse);
      });
    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Watch List')),
      body: watches.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: watches.length,
              itemBuilder: (context, index) {
                final watch = watches[index];
                final photos = watch['photos'] as List<dynamic>?;
                final imageUrl = (photos != null && photos.isNotEmpty)
                    ? 'https://api.timbu.cloud/images/${photos[0]['url']}'
                    : '';
                final name = watch['name'] ?? 'Unknown Watch';
                final price =
                    watch['current_price']?[0]['USD']?[0]?.toString() ?? 'N/A';

                return Card(
                  child: ListTile(
                    leading: imageUrl.isNotEmpty
                        ? Image.network(imageUrl,
                            errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.broken_image);
                          })
                        : Icon(Icons.watch),
                    // title: Text('Image URL: $imageUrl'),
                    title: Text(name),
                    subtitle: Text('\$$price'),
                  ),
                );
              },
            ),
    );
  }
}
