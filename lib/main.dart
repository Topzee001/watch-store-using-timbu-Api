import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timbu_app/pages/homepage.dart';

import 'providers/cart_provider.dart';
//import 'watchlist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider()
        ..fetchWatches(), // Initialize CartProvider and fetch watches using cascade notation
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Timbu App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
        //WatchListScreen(),
      ),
    );
  }
}
