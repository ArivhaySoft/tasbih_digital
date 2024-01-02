import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasbih_digital/model_alquran_surat.dart' as modelQuranSurat;
import 'package:tasbih_digital/model_alquran_surat_daftar.dart'  as modelQuranSuratDaftar;
import 'package:tasbih_digital/utils_ui.dart';

class AlQuran extends StatefulWidget {
  const AlQuran({super.key});

  @override
  State<AlQuran> createState() => _AlQuranState();
}

class _AlQuranState extends State<AlQuran> {


  @override
  void initState() {
   super.initState();


  }

 Future<List<modelQuranSuratDaftar.Data>> _ambilDaftarSurat() async {
   var response = await rootBundle.loadString('asset/json/alquran/daftar_surat.json');
   var resData = modelQuranSuratDaftar.ModelAlquranSuratDaftar.fromJson(json.decode(response));
   return resData.data!.toList();
 }


  Future<List<modelQuranSurat.Data>> _ambilSurat(int surat) async {
    final String response = await rootBundle.loadString('asset/json/alquran/$surat.json');
    var resData = modelQuranSurat.ModelAlquranSurat.fromJson(json.decode(response));
    return resData.data!.toList();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Al - Quran'),
      ),
      body:  FutureBuilder(
        future: _ambilDaftarSurat(),
        builder: (BuildContext context, AsyncSnapshot<List<modelQuranSuratDaftar.Data>> snapshot) {

          if(snapshot.hasData) {
            return ListView(
              children: snapshot.data!
                  .map((data) =>
                  Container(
                    child: Column(
                      children: [
                        Text(data.suratText.toString() + ' ( ' + data.countAyat.toString() + ' )'),
                        Text(data.suratName.toString() ),
                        Text(data.suratTerjemahan.toString())
                      ],
                    ),
                  ))
                  .toList(),
            );
          }else{
            return Text('Mohon Tunggu');
          }
        },
      ),
    );
  }
}
