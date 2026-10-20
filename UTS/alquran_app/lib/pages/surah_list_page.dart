import 'package:flutter/material.dart';

import '../models/surah.dart';
import '../services/quran_api_service.dart';
import '../widgets/state_views.dart';
import 'surah_detail_page.dart';

/// Halaman utama: daftar 114 surah dengan fitur pencarian.
class SurahListPage extends StatefulWidget {
  /// [service] bisa diisi saat pengujian; jika kosong dipakai service asli.
  final QuranApiService? service;

  const SurahListPage({super.key, this.service});

  @override
  State<SurahListPage> createState() => _SurahListPageState();
}

class _SurahListPageState extends State<SurahListPage> {
  late final QuranApiService _service;
  late Future<List<Surah>> _futureSurah;
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _service = widget.service ?? QuranApiService();
    _futureSurah = _service.fetchSurahList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _reload() {
    setState(() {
      _futureSurah = _service.fetchSurahList();
    });
  }

  List<Surah> _filter(List<Surah> all) {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return all;
    return all
        .where(
          (s) =>
              s.namaLatin.toLowerCase().contains(q) ||
              s.arti.toLowerCase().contains(q) ||
              s.nomor.toString() == q,
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Surah Al-Qur'an"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Surah>>(
        future: _futureSurah,
        builder: (context, snapshot) {
          // Kondisi 1: Loading
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingView(message: 'Memuat daftar surah...');
          }

          // Kondisi 2: Error
          if (snapshot.hasError) {
            return ErrorView(
              message: describeError(snapshot.error),
              onRetry: _reload,
            );
          }

          // Kondisi 3: Success
          final filtered = _filter(snapshot.data ?? <Surah>[]);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _query = value),
                  decoration: InputDecoration(
                    hintText: 'Cari surah (nama, arti, atau nomor)',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _query.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _query = '');
                            },
                          ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: filtered.isEmpty
                    ? const Center(child: Text('Surah tidak ditemukan'))
                    : ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) =>
                            _SurahTile(surah: filtered[index], service: _service),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SurahTile extends StatelessWidget {
  final Surah surah;
  final QuranApiService service;

  const _SurahTile({required this.surah, required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(child: Text('${surah.nomor}')),
        title: Text(
          surah.namaLatin,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${surah.arti} • ${surah.jumlahAyat} ayat • ${surah.tempatTurun}',
        ),
        trailing: Text(
          surah.nama,
          textDirection: TextDirection.rtl,
          style: const TextStyle(fontSize: 22),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SurahDetailPage(surah: surah, service: service),
            ),
          );
        },
      ),
    );
  }
}
