import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/surah.dart';
import '../models/surah_detail.dart';

/// Kesalahan yang dilempar service dengan pesan yang siap ditampilkan ke pengguna.
class ApiException implements Exception {
  final String message;

  const ApiException(this.message);

  @override
  String toString() => message;
}

/// Mengubah error apa pun menjadi pesan yang mudah dipahami pengguna.
String describeError(Object? error) {
  if (error is ApiException) return error.message;
  return 'Terjadi kesalahan yang tidak terduga.';
}

/// Service untuk mengambil data dari API EQuran.id.
class QuranApiService {
  static const String baseUrl = 'https://equran.id/api/v2';
  static const Duration _timeout = Duration(seconds: 15);

  final http.Client _client;

  /// [client] bisa diganti (misalnya MockClient) agar mudah diuji.
  QuranApiService({http.Client? client}) : _client = client ?? http.Client();

  /// Mengambil daftar 114 surah.
  Future<List<Surah>> fetchSurahList() async {
    final data = await _getData('/surat');
    if (data is! List) {
      throw const ApiException('Format data daftar surah tidak sesuai.');
    }
    try {
      return data
          .map((item) => Surah.fromJson(item as Map<String, dynamic>))
          .toList();
    } on TypeError {
      throw const ApiException('Data surah tidak dapat diproses.');
    }
  }

  /// Mengambil detail satu surah beserta seluruh ayatnya.
  Future<SurahDetail> fetchSurahDetail(int nomor) async {
    final data = await _getData('/surat/$nomor');
    if (data is! Map<String, dynamic>) {
      throw const ApiException('Format data detail surah tidak sesuai.');
    }
    try {
      return SurahDetail.fromJson(data);
    } on TypeError {
      throw const ApiException('Data detail surah tidak dapat diproses.');
    }
  }

  /// Mengirim permintaan GET, memeriksa status respons, lalu mengembalikan
  /// isi field `data` dari JSON.
  Future<dynamic> _getData(String path) async {
    final uri = Uri.parse('$baseUrl$path');
    try {
      final response = await _client.get(uri).timeout(_timeout);

      if (response.statusCode != 200) {
        throw ApiException(
          'Server mengembalikan status ${response.statusCode}.',
        );
      }

      final body = jsonDecode(utf8.decode(response.bodyBytes));
      if (body is! Map<String, dynamic> || !body.containsKey('data')) {
        throw const ApiException('Struktur respons API tidak sesuai.');
      }
      return body['data'];
    } on SocketException {
      throw const ApiException(
        'Tidak dapat terhubung ke server. Periksa koneksi internet.',
      );
    } on http.ClientException {
      throw const ApiException(
        'Tidak dapat terhubung ke server. Periksa koneksi internet.',
      );
    } on TimeoutException {
      throw const ApiException('Waktu permintaan habis. Coba lagi nanti.');
    } on FormatException {
      throw const ApiException('Data dari server bukan JSON yang valid.');
    }
  }
}
