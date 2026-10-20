import '../utils/text_utils.dart';

/// Model satu ayat pada endpoint detail surah.
class Ayat {
  final int nomorAyat;
  final String teksArab;
  final String teksLatin;
  final String teksIndonesia;

  const Ayat({
    required this.nomorAyat,
    required this.teksArab,
    required this.teksLatin,
    required this.teksIndonesia,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
      nomorAyat: (json['nomorAyat'] as num).toInt(),
      teksArab: json['teksArab'] as String? ?? '',
      teksLatin: json['teksLatin'] as String? ?? '',
      teksIndonesia: json['teksIndonesia'] as String? ?? '',
    );
  }
}

/// Model detail surah (`GET /api/v2/surat/{nomor}`) beserta daftar ayatnya.
class SurahDetail {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final List<Ayat> ayat;

  const SurahDetail({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.ayat,
  });

  factory SurahDetail.fromJson(Map<String, dynamic> json) {
    final rawAyat = json['ayat'] as List<dynamic>? ?? <dynamic>[];
    return SurahDetail(
      nomor: (json['nomor'] as num).toInt(),
      nama: json['nama'] as String? ?? '',
      namaLatin: json['namaLatin'] as String? ?? '',
      jumlahAyat: (json['jumlahAyat'] as num?)?.toInt() ?? 0,
      tempatTurun: json['tempatTurun'] as String? ?? '',
      arti: json['arti'] as String? ?? '',
      deskripsi: stripHtml(json['deskripsi'] as String? ?? ''),
      ayat: rawAyat
          .map((e) => Ayat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
