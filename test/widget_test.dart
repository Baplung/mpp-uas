import 'package:flutter_test/flutter_test.dart';
import 'package:uas/main.dart';

void main() {
  testWidgets('LokaTrip menampilkan halaman beranda dan status GPS', (
    tester,
  ) async {
    await tester.pumpWidget(const LokaTripApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('Selamat datang,'), findsOneWidget);
    expect(find.textContaining('Temukan tempat'), findsOneWidget);
    expect(find.textContaining('Lokasi GPS Aktif'), findsOneWidget);
  });

  testWidgets('LokaTrip dapat bernavigasi ke tab Jadwal Rencana Wisata', (
    tester,
  ) async {
    await tester.pumpWidget(const LokaTripApp());
    await tester.pumpAndSettle();

    // Tap nav item Jadwal
    final jadwalTab = find.text('Jadwal');
    expect(jadwalTab, findsOneWidget);
    await tester.tap(jadwalTab);
    await tester.pumpAndSettle();

    expect(find.text('Rencana Wisata'), findsOneWidget);
    expect(find.text('Tambah'), findsOneWidget);
    expect(find.text('Total Jadwal'), findsOneWidget);
  });

  testWidgets('LokaTrip dapat bernavigasi ke tab Eksplorasi & Tersimpan', (
    tester,
  ) async {
    await tester.pumpWidget(const LokaTripApp());
    await tester.pumpAndSettle();

    // Tap nav item Eksplorasi
    await tester.tap(find.text('Eksplorasi'));
    await tester.pumpAndSettle();
    expect(find.text('Cari destinasi atau kota...'), findsOneWidget);

    // Tap nav item Tersimpan
    await tester.tap(find.text('Tersimpan'));
    await tester.pumpAndSettle();
    expect(find.textContaining('destinasi disimpan'), findsOneWidget);
  });
}
