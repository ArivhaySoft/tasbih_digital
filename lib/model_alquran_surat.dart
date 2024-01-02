class ModelAlquranSurat {
  ModelAlquranSurat({
      this.data,});

  ModelAlquranSurat.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      this.ayaId, 
      this.ayaNumber, 
      this.ayaText, 
      this.suraId, 
      this.juzId, 
      this.pageNumber, 
      this.translationAyaText,});

  Data.fromJson(dynamic json) {
    ayaId = json['aya_id'];
    ayaNumber = json['aya_number'];
    ayaText = json['aya_text'];
    suraId = json['sura_id'];
    juzId = json['juz_id'];
    pageNumber = json['page_number'];
    translationAyaText = json['translation_aya_text'];
  }
  int? ayaId;
  int? ayaNumber;
  String? ayaText;
  int? suraId;
  int? juzId;
  int? pageNumber;
  String? translationAyaText;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['aya_id'] = ayaId;
    map['aya_number'] = ayaNumber;
    map['aya_text'] = ayaText;
    map['sura_id'] = suraId;
    map['juz_id'] = juzId;
    map['page_number'] = pageNumber;
    map['translation_aya_text'] = translationAyaText;
    return map;
  }

}