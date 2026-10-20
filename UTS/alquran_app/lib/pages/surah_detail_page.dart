import 'package:flutter/material.dart';

import '../models/surah.dart';
import '../models/surah_detail.dart';
import '../services/quran_api_service.dart';
import '../widgets/state_views.dart';

/// Halaman detail: menampilkan seluruh ayat dari surah yang dipilih.
class SurahDetailPage extends StatefulWidget {
  final Surah surah;
  final QuranApiService? service;

  const SurahDetailPage({super.key, required this.surah, this.service});

  @override
  State<SurahDetailPage> createState() => _SurahDetailPageState();
}

class _SurahDetailPageState extends State<SurahDetailPage> {
  late final QuranApiService _service;
  late Future<SurahDetail> _futureDetail;

  @override
  void initState() {
    super.initState();
    _service = widget.service ?? QuranApiService();
    _futureDetail = _service.fetchSurahDetail(widget.surah.nomor);
  }

  void _reload() {
    setState(() {
      _futureDetail = _service.fetchSurahDetail(widget.surah.nomor);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.surah.namaLatin), centerTitle: true),
      body: FutureBuilder<SurahDetail>(
        future: _futureDetail,
        builder: (context, snapshot) {
          // Kondisi 1: Loading
          if (snapshot.connectionState != ConnectionState.done) {
            return LoadingView(
              message: 'Memuat ayat ${widget.surah.namaLatin}...',
            );
          }

          // Kondisi 2: Error
          if (snapshot.hasError) {
            return ErrorView(
              message: describeError(snapshot.error),
              onRetry: _reload,
            );
          }

          // Kondisi 3: Success
          final detail = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: detail.ayat.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) return _HeaderCard(detail: detail);
              return _AyatCard(ayat: detail.ayat[index - 1]);
            },
          );
        },
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final SurahDetail detail;

  const _HeaderCard({required this.detail});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.primaryContainer,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              detail.nama,
              textDirection: TextDirection.rtl,
              style: const TextStyle(fontSize: 34),
            ),
            const SizedBox(height: 8),
            Text(
              detail.arti,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text('${detail.tempatTurun} • ${detail.jumlahAyat} ayat'),
            if (detail.deskripsi.isNotEmpty)
              ExpansionTile(
                title: const Text('Tentang surah'),
                tilePadding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(detail.deskripsi),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _AyatCard extends StatelessWidget {
  final Ayat ayat;

  const _AyatCard({required this.ayat});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 14,
              child: Text(
                '${ayat.nomorAyat}',
                style: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Text(
                ayat.teksArab,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: const TextStyle(fontSize: 26, height: 1.9),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              ayat.teksLatin,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: scheme.primary,
              ),
            ),
            const SizedBox(height: 6),
            Text(ayat.teksIndonesia),
          ],
        ),
      ),
    );
  }
}
