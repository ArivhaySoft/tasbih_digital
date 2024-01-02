class ModelAlquranSuratDaftar {
  ModelAlquranSuratDaftar({
      this.msg, 
      this.data,});

  ModelAlquranSuratDaftar.fromJson(dynamic json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  String? msg;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.suratName, 
      this.suratText, 
      this.suratTerjemahan, 
      this.countAyat,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    suratName = json['surat_name'];
    suratText = json['surat_text'];
    suratTerjemahan = json['surat_terjemahan'];
    countAyat = json['count_ayat'];
  }
  int? id;
  String? suratName;
  String? suratText;
  String? suratTerjemahan;
  int? countAyat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['surat_name'] = suratName;
    map['surat_text'] = suratText;
    map['surat_terjemahan'] = suratTerjemahan;
    map['count_ayat'] = countAyat;
    return map;
  }

}