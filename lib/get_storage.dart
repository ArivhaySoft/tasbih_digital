import 'dart:convert';

import 'package:get_storage/get_storage.dart';

class GetStoragePref {
  final box = GetStorage();

  //GetStoradge
  final _cariRiwayat = "_cariRiwayat";

  String? getTasbih() {
    try {
      return box.read(_cariRiwayat) == null ? '' : box.read(_cariRiwayat);
    } catch (e) {
      return '';
    }
  }

  void setTasbih(String? value) {
    if (value != null) {
      box.write(_cariRiwayat, value);
    }
  }


  void putCache(String key, String value, int jam) {
    // print('putCache : ' + key + ' ' + jam.toString() + ' : ' + value);
    box.write(key, value);
    //tanggal disimpan
    box.write(key + "LastUpdate", DateTime.now().millisecondsSinceEpoch);
    //hitungan jam
    box.write(key + "Lama", jam * 60 * 60 * 1000);
  }

  String? getCache(String key) {
    // print('getCache : ' + key);
    if (!box.hasData(key)) {
      return '';
    }
    int now = DateTime.now().millisecondsSinceEpoch;
    int last = box.read(key + "LastUpdate") ?? 0;
    int lama = box.read(key + "Lama") ?? 0;
    int rem = now - last;
    if (rem > lama) {
      return '';
    }
    return box.read(key);
  }

  String? getString(String key) {
    try {
      return box.read(key) == null ? '' : box.read(key);
    } catch (e) {
      return '';
    }
  }

  void setString(String? key, String? value) {
    if (value != null) {
      box.write(key!, value);
    }
  }

  void removeBox(String? key) {
    box.remove(key!);
  }

  /*
   * Saat logout, panggil ini untuk hapus data
   */
  void logout() {
    box.erase();
  }
}

final getBox = GetStoragePref();
