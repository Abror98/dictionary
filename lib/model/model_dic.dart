import 'dart:convert';

List<Dictionary> dictionaryFromJson(String str) => List<Dictionary>.from(json.decode(str).map((x) => Dictionary.fromJson(x)));

String dictionaryToJson(List<Dictionary> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dictionary {
  Dictionary({
    this.en,
    this.uz,
  });

  String en;
  String uz;

  factory Dictionary.fromJson(Map<String, dynamic> json) => Dictionary(
    en: json["en"],
    uz: json["uz"],
  );

  Map<String, dynamic> toJson() => {
    "en": en,
    "uz": uz,
  };
}
