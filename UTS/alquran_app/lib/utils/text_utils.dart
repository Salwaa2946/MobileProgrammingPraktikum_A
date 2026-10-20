/// Membersihkan tag HTML sederhana (misalnya <i> dan <br>) dari teks API.
///
/// Field `deskripsi` pada API EQuran.id berisi tag HTML. Jika ditampilkan
/// langsung pada widget Text, tag tersebut ikut muncul sebagai teks biasa.
String stripHtml(String input) {
  return input
      .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
      .replaceAll(RegExp(r'<[^>]*>'), '')
      .trim();
}
