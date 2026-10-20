import 'package:flutter/material.dart';

import 'pages/surah_list_page.dart';

void main() {
  runApp(const AlQuranApp());
}

class AlQuranApp extends StatelessWidget {
  const AlQuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Al-Qur'an Digital",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B6B50)),
        useMaterial3: true,
      ),
      home: const SurahListPage(),
    );
  }
}
