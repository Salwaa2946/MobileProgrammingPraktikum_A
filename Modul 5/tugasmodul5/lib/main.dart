import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sedang memutar'),
          centerTitle: true,
        ),
        body: Center(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: 330,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Cover album
                    const Icon(
                      Icons.album,
                      size: 100,
                      color: Colors.blueGrey,
                    ),

                    const SizedBox(height: 12),

                    // Judul lagu dan artis
                    Row(
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Di sini ada judul lagu',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Di sini nama artis',
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        // Tombol like
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}