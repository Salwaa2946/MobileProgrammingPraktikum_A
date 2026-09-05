import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Praktikum',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('Tugas Praktikum'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KotakWarna(warna: Colors.blue, label: 'Biru'),
                  SizedBox(width: 12), // jarak antar kotak
                  KotakWarna(warna: Colors.yellow, label: 'Kuning'),
                ],
              ),
              SizedBox(height: 12), // jarak antar baris
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KotakWarna(warna: Colors.pink, label: 'Pink'),
                  SizedBox(width: 12),
                  KotakWarna(warna: Colors.purple, label: 'Ungu'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget kustom kotak warna + icon + Text di bawahnya (pakai Column)
class KotakWarna extends StatelessWidget {
  final Color warna;
  final String label;

  const KotakWarna({
    Key? key,
    required this.warna,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          color: warna,
          child: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
        SizedBox(height: 4), // jarak antara kotak dan text
        Text(label), // text di bawah icon
      ],
    );
  }
}