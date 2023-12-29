import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlQuran extends StatefulWidget {
  const AlQuran({super.key});

  @override
  State<AlQuran> createState() => _AlQuranState();
}

class _AlQuranState extends State<AlQuran> {

 List<String> = [];

  @override
  void initState() {
    super.initState();
  }

  Future<String> readJson(int ayat) async {
    final String response = await rootBundle.loadString('asset/json/alguran/$ayat.json');
    final data = await json.decode(response);
    return data;
  }

  String ambilJson(String ayat,String key){
    var hasil = "";
    var list = json.decode(ayat.toString()) as List<dynamic>;
    for (var json in list) {
      hasil = json[key];
    }
    return hasil;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ya Sin'),
      ),
      body: ,
    );
  }
}
