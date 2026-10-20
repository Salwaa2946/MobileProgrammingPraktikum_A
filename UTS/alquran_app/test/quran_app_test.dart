import 'dart:convert';

import 'package:alquran_app/models/surah.dart';
import 'package:alquran_app/pages/surah_list_page.dart';
import 'package:alquran_app/services/quran_api_service.dart';
import 'package:alquran_app/utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

/// Membuat respons HTTP berisi JSON (UTF-8) untuk MockClient.
http.Response _jsonResponse(Object body, [int status = 200]) {
  return http.Response.bytes(
    utf8.encode(jsonEncode(body)),
    status,
    headers: {'content-type': 'application/json; charset=utf-8'},
  );
}

final Map<String, dynamic> _listBody = {
  'code': 200,
  'message': 'Data retrieved successfully',
  'data': [
    {
      'nomor': 1,
      'nama': 'الفاتحة',
      'namaLatin': 'Al-Fatihah',
      'jumlahAyat': 7,
      'tempatTurun': 'Mekah',
      'arti': 'Pembukaan',
      'deskripsi': 'Surat <i>Al Faatihah</i> (Pembukaan).<br>Baris kedua.',
    },
    {
      'nomor': 2,
      'nama': 'البقرة',
      'namaLatin': 'Al-Baqarah',
      'jumlahAyat': 286,
      'tempatTurun': 'Madinah',
      'arti': 'Sapi',
      'deskripsi': 'Surat Al Baqarah.',
    },
  ],
};

final Map<String, dynamic> _detailBody = {
  'code': 200,
  'message': 'Data retrieved successfully',
  'data': {
    'nomor': 1,
    'nama': 'الفاتحة',
    'namaLatin': 'Al-Fatihah',
    'jumlahAyat': 7,
    'tempatTurun': 'Mekah',
    'arti': 'Pembukaan',
    'deskripsi': 'Surat <i>Al Faatihah</i>.',
    'ayat': [
      {
        'nomorAyat': 1,
        'teksArab': 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
        'teksLatin': 'bismillahir rahmanir rahim',
        'teksIndonesia': 'Dengan nama Allah Yang Maha Pengasih, Maha Penyayang.',
      },
    ],
  },
};

void main() {
  group('Model dan utilitas', () {
    test('stripHtml menghapus tag dan mengubah <br> menjadi baris baru', () {
      expect(stripHtml('Surat <i>Al Faatihah</i>.<br>Baris dua'),
          'Surat Al Faatihah.\nBaris dua');
    });

    test('Surah.fromJson mengubah JSON menjadi objek Dart', () {
      final surah = Surah.fromJson(
        (_listBody['data'] as List).first as Map<String, dynamic>,
      );
      expect(surah.nomor, 1);
      expect(surah.namaLatin, 'Al-Fatihah');
      expect(surah.jumlahAyat, 7);
      expect(surah.deskripsi, isNot(contains('<i>')));
    });
  });

  group('QuranApiService', () {
    test('fetchSurahList berhasil mengubah respons menjadi list Surah',
        () async {
      final service = QuranApiService(
        client: MockClient((_) async => _jsonResponse(_listBody)),
      );
      final result = await service.fetchSurahList();
      expect(result.length, 2);
      expect(result[1].namaLatin, 'Al-Baqarah');
    });

    test('fetchSurahDetail berhasil membaca daftar ayat', () async {
      final service = QuranApiService(
        client: MockClient((_) async => _jsonResponse(_detailBody)),
      );
      final detail = await service.fetchSurahDetail(1);
      expect(detail.ayat.length, 1);
      expect(detail.ayat.first.nomorAyat, 1);
    });

    test('status selain 200 memunculkan ApiException', () async {
      final service = QuranApiService(
        client: MockClient((_) async => _jsonResponse({'error': 'x'}, 500)),
      );
      await expectLater(
        service.fetchSurahList(),
        throwsA(isA<ApiException>()),
      );
    });

    test('JSON tidak valid memunculkan ApiException', () async {
      final service = QuranApiService(
        client: MockClient(
          (_) async => http.Response.bytes(utf8.encode('bukan json'), 200),
        ),
      );
      await expectLater(
        service.fetchSurahList(),
        throwsA(isA<ApiException>()),
      );
    });

    test('kegagalan jaringan memunculkan ApiException', () async {
      final service = QuranApiService(
        client: MockClient((_) async => throw http.ClientException('offline')),
      );
      await expectLater(
        service.fetchSurahList(),
        throwsA(isA<ApiException>()),
      );
    });
  });

  group('SurahListPage (FutureBuilder)', () {
    Future<void> pumpPage(WidgetTester tester, http.Client client) {
      return tester.pumpWidget(
        MaterialApp(
          home: SurahListPage(service: QuranApiService(client: client)),
        ),
      );
    }

    testWidgets('menampilkan loading lalu daftar surah', (tester) async {
      await pumpPage(
        tester,
        MockClient((_) async => _jsonResponse(_listBody)),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Al-Fatihah'), findsOneWidget);
      expect(find.text('Al-Baqarah'), findsOneWidget);
    });

    testWidgets('menampilkan pesan error dan tombol Coba Lagi', (tester) async {
      await pumpPage(
        tester,
        MockClient((_) async => _jsonResponse({'error': 'x'}, 500)),
      );
      await tester.pumpAndSettle();

      expect(find.text('Gagal memuat data'), findsOneWidget);
      expect(find.textContaining('500'), findsOneWidget);
      expect(find.text('Coba Lagi'), findsOneWidget);
    });

    testWidgets('pencarian menyaring daftar surah', (tester) async {
      await pumpPage(
        tester,
        MockClient((_) async => _jsonResponse(_listBody)),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'baqarah');
      await tester.pump();

      expect(find.text('Al-Fatihah'), findsNothing);
      expect(find.text('Al-Baqarah'), findsOneWidget);
    });
  });
}
