import '../utils/text_utils.dart';

/// Model satu surah pada endpoint daftar surah (`GET /api/v2/surat`).
class Surah {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;

  const Surah({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
  });

  /// Mengubah satu objek JSON menjadi objek [Surah].
  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      nomor: (json['nomor'] as num).toInt(),
      nama: json['nama'] as String? ?? '',
      namaLatin: json['namaLatin'] as String? ?? '',
      jumlahAyat: (json['jumlahAyat'] as num?)?.toInt() ?? 0,
      tempatTurun: json['tempatTurun'] as String? ?? '',
      arti: json['arti'] as String? ?? '',
      deskripsi: stripHtml(json['deskripsi'] as String? ?? ''),
    );
  }
}
