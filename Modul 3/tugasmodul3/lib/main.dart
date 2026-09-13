import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Cuaca',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Nama Kota
              const Text(
                'Malang',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Expanded(
                child: Center(
                  child: Text(
                    '25°',
                    style: TextStyle(
                      fontSize: 120,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    RamalanHarian(
                      hari: 'Minggu',
                      icon: Icons.sunny,
                      suhu: '20°C',
                    ),
                    RamalanHarian(
                      hari: 'Senin',
                      icon: Icons.cloudy_snowing,
                      suhu: '23°C',
                    ),
                    RamalanHarian(
                      hari: 'Selasa',
                      icon: Icons.cloud,
                      suhu: '22°C',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RamalanHarian extends StatelessWidget {
  final String hari;
  final IconData icon;
  final String suhu;

  const RamalanHarian({
    super.key,
    required this.hari,
    required this.icon,
    required this.suhu,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          hari,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 12),
        Icon(icon, color: Colors.black87, size: 50),
        const SizedBox(height: 12),
        Text(
          suhu,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }
}