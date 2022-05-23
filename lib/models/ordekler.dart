// To parse this JSON data, do
//
//     final ordek = ordekFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Ordek ordekFromMap(String str) => Ordek.fromMap(json.decode(str));

String ordekToMap(Ordek data) => json.encode(data.toMap());

class Ordek {
    Ordek({
        required this.ordekTuru,
        required this.ordekBoyu,
        required this.ordekSulalesi,
    });

    final String ordekTuru;
    final String ordekBoyu;
    final List<OrdekSulalesi> ordekSulalesi;

    factory Ordek.fromMap(Map<String, dynamic> json) => Ordek(
        ordekTuru: json["ordek_turu"],
        ordekBoyu: json["ordek_boyu"],
        ordekSulalesi: List<OrdekSulalesi>.from(json["ordek_sulalesi"].map((x) => OrdekSulalesi.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "ordek_turu": ordekTuru,
        "ordek_boyu": ordekBoyu,
        "ordek_sulalesi": List<dynamic>.from(ordekSulalesi.map((x) => x.toMap())),
    };
}

class OrdekSulalesi {
    OrdekSulalesi({
        required this.dedeAdi,
        required this.babaAdi,
    });

    final String dedeAdi;
    final String babaAdi;

    factory OrdekSulalesi.fromMap(Map<String, dynamic> json) => OrdekSulalesi(
        dedeAdi: json["dede_adi"],
        babaAdi: json["baba_adi"],
    );

    Map<String, dynamic> toMap() => {
        "dede_adi": dedeAdi,
        "baba_adi": babaAdi,
    };
}
