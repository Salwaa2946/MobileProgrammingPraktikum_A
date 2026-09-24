import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2196F3),

      appBar: AppBar(
        title: const Text(
          "Ini Halaman Utama",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF2196F3),
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Banyak aplikasi memiliki beberapa layar untuk"
              "menampilkan informasi yang berbeda. Contohnya,"
              "ada layar produk, akan muncul layar dengan detail produk tersebut" ,
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
                  'assets/images/house.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Text(
              "Pertama, kita perlu membuat dua halaman atau 'routes' "
              "yang ingin kita tampilkan. Selanjutnya, kita gunakan perintah "
              "Navigator.push() untuk berpindah dari halaman pertama ke halaman kedua."
              "Ini seperti kita membuka halaman baru. Terakhir, kita bisa kembali dari halaman kedua ke halaman pertama menggunakan Navigator.pop(). "
              "Seperti menutup halaman kedua dan kembali ke halaman pertama.",
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
                  Navigator.pushNamed(context, '/tujuan');
                },
                child: const Text("Ke Halaman Tujuan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}