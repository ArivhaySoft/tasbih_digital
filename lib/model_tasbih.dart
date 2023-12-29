class ModelTasbih {
  int? id;
  String? judul;
  String? durasi;
  String? kelompok;
  int? tasbih;
  int? tasbish_last;
  String? tassbih_start;
  String? tassbih_end;

  ModelTasbih(
      {required this.id,
        required this.judul,
        required this.durasi,
        required this.kelompok,
        required this.tasbih,
        required this.tasbish_last,
        required this.tassbih_start,
        required this.tassbih_end});

  ModelTasbih.fromJson(dynamic json) {
    id = json["id"] ?? 0;
    judul = json["judul"];
    durasi = json["durasi"];
    kelompok = json["kelompok"];
    tasbih = json["tasbih"];
    tasbish_last = json["tasbish_last"];
    tassbih_start = json["tassbih_start"];
    tassbih_end = json["tassbih_end"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["judul"] = judul;
    map["durasi"] = durasi;
    map["kelompok"] = kelompok;
    map["tasbih"] = tasbih;
    map["tasbish_last"] = tasbish_last;
    map["tassbih_start"] = tassbih_start;
    map["tassbih_end"] = tassbih_end;
    return map;
  }
}