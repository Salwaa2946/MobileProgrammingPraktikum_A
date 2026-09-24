import 'package:flutter/material.dart';

class TujuanPage extends StatelessWidget {
  const TujuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF4935),

      appBar: AppBar(
        title: const Text(
          "Ini Halaman Tujuan",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFF4935),
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Untuk berpindah ke halaman baru, gunakan "
                  "metode Navigator.push(). Metode push() "
                  "akan menambahkan Route ke dalam tumpukan "
                  "Route yang dikelola oleh Navigator."
                  "Route ini dapat dibuat secara kustom atau menggunakan"
                  "MaterialPageRoute, yang memiliki animasi"
                  "transisi sesuai dengan platform yang digunakan",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),

            Center(
              child: Container(
                width: 145,
                height: 145,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  'assets/images/island.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const Text(
              "Untuk menutup halaman kedua dan kembali "
                  "ke halaman pertama, gunakan metode "
                  "Navigator.pop(). Metode pop() akan "
                  "menghapus Route saat ini dari tumpukan "
                  "Route yang dikelola oleh Navigator.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("‹ Kembali ke home"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}