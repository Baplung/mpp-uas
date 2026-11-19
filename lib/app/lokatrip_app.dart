import 'package:flutter/material.dart';

import '../data/destinations.dart';
import '../models/user_location.dart';
import '../screens/detail_page.dart';
import '../screens/main_shell.dart';

class LokaTripApp extends StatelessWidget {
  final int initialIndex;
  const LokaTripApp({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    int startTab = initialIndex;
    String? detailId;
    try {
      final tabParam = Uri.base.queryParameters['tab'];
      if (tabParam != null) {
        startTab = int.tryParse(tabParam) ?? initialIndex;
      }
      detailId = Uri.base.queryParameters['detail'];
    } catch (_) {}

    if (detailId != null) {
      final dest = allDestinations.firstWhere(
        (d) => d.id == detailId,
        orElse: () => allDestinations.first,
      );
      return MaterialApp(
        title: 'LokaTrip',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFF9F9FF),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF5B46E8),
            primary: const Color(0xFF5B46E8),
            surface: const Color(0xFFF9F9FF),
          ),
          fontFamily: 'Segoe UI',
          useMaterial3: true,
        ),
        home: DetailPage(
          destination: dest,
          userLocation: availableLocations.first,
          isSaved: true,
          onToggleSaved: () {},
        ),
      );
    }

    return MaterialApp(
      title: 'LokaTrip',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F9FF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B46E8),
          primary: const Color(0xFF5B46E8),
          surface: const Color(0xFFF9F9FF),
        ),
        fontFamily: 'Segoe UI',
        useMaterial3: true,
      ),
      home: MainShell(initialIndex: startTab),
    );
  }
}
