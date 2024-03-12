import 'package:flutter/material.dart';
import 'package:currency_converter/HomePage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String request = "https://api.hgbrasil.com/finance?key=d31bf6a9";


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<Map> getData() async {

  var response = await http.get(Uri.parse(request));
  var data;

  data = jsonDecode(response.body);
  return data;

}
