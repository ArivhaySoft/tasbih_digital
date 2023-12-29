import 'dart:convert';

import 'package:get_storage/get_storage.dart';

class GetStoragePref {
  final box = GetStorage();

  final _tasbih_kelompok = "_tasbih_kelompok";
  final _tasbih_counter = "_tasbih_counter";

  String? getTasbih() {
    try {
      return box.read(_tasbih_kelompok) ?? '';
    } catch (e) {
      return '';
    }
  }

  void setTasbih(String? value) {
    if (value != null) {
      box.write(_tasbih_kelompok, value);
    }
  }

  int? getCounter() {
    try {
      return box.read(_tasbih_counter) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  void setCounter(int? value) {
    if (value != null) {
      box.write(_tasbih_counter, value);
    }
  }

  void removeBox(String? key) {
    box.remove(key!);
  }

  /*
   * Saat logout, panggil ini untuk hapus data
   */
  void clear() {
    box.erase();
  }
}

final getBox = GetStoragePref();
