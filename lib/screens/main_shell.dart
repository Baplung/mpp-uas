import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/itinerary.dart';
import '../models/notification_item.dart';
import '../models/user_location.dart';
import 'explore_page.dart';
import 'home_page.dart';
import 'itinerary_page.dart';
import 'saved_page.dart';

class MainShell extends StatefulWidget {
  final int initialIndex;
  const MainShell({super.key, this.initialIndex = 0});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final Set<String> _savedIds = {'bromo', 'raja_ampat'};
  UserLocation _userLocation = availableLocations.first; // Malang UIN default

  // Data Dinamis Itinerary (Rencana Wisata)
  final List<Itinerary> _itineraries = [
    Itinerary(
      id: 'itin_1',
      destinationId: 'bromo',
      destinationName: 'Taman Nasional Bromo Tengger Semeru',
      destinationImage: 'assets/images/bromo_choice.jpg',
      location: 'Probolinggo, Jawa Timur',
      visitDate: DateTime.now().add(const Duration(days: 3)),
      visitTime: '04:30 WIB',
      estimatedBudget: 350000,
      notes:
          'Sewa jeep sunrise di Penanjakan 1, bawa jaket tebal & masker kawah.',
      isCompleted: false,
    ),
    Itinerary(
      id: 'itin_2',
      destinationId: 'gudeg',
      destinationName: 'Gudeg Yu Djum Wijilan',
      destinationImage: 'assets/images/kuliner.jpg',
      location: 'Yogyakarta',
      visitDate: DateTime.now().add(const Duration(days: 10)),
      visitTime: '12:00 WIB',
      estimatedBudget: 75000,
      notes:
          'Makan siang bareng keluarga, bungkus paket besek untuk oleh-oleh.',
      isCompleted: true,
    ),
  ];

  // Data Notifikasi Dinamis (Cuaca & Pengingat Jadwal)
  final List<NotificationItem> _notifications = [
    NotificationItem(
      id: 'notif_1',
      title: 'Prakiraan Cuaca Bromo Dingin & Berkabut',
      message: 'Suhu puncak Bromo terpantau 12°C dengan kabut tebal pagi hari. Disarankan menyiapkan jaket windbreaker dan syal.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
      type: NotificationType.weather,
      isRead: false,
    ),
    NotificationItem(
      id: 'notif_2',
      title: 'Pengingat Jadwal Tour Bromo',
      message: 'Jadwal keberangkatan ke Bromo tersisa 3 hari lagi. Pastikan akomodasi jeep dan tiket TNBTS sudah siap.',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      type: NotificationType.schedule,
      isRead: false,
    ),
    NotificationItem(
      id: 'notif_3',
      title: 'Pembaruan Lokasi GPS Aktif',
      message: 'Lokasi berhasil disinkronkan dengan koordinat Malang (UIN Maliki). Jarak semua destinasi telah disesuaikan otomatis.',
      timestamp: DateTime.now().subtract(const Duration(hours: 8)),
      type: NotificationType.info,
      isRead: true,
    ),
  ];

  void _toggleSaved(String id) {
    setState(() {
      if (_savedIds.contains(id)) {
        _savedIds.remove(id);
      } else {
        _savedIds.add(id);
      }
    });
  }

  bool _isSaved(String id) => _savedIds.contains(id);

  void _updateUserLocation(UserLocation newLocation) {
    setState(() {
      _userLocation = newLocation;
      _notifications.insert(
        0,
        NotificationItem(
          id: 'notif_${DateTime.now().millisecondsSinceEpoch}',
          title: 'Lokasi Berubah ke ${newLocation.name}',
          message:
              'Perhitungan jarak real-time kini menggunakan titik koordinat ${newLocation.label}.',
          timestamp: DateTime.now(),
          type: NotificationType.info,
          isRead: false,
        ),
      );
    });
  }

  void _addItinerary(Itinerary newItin) {
    setState(() {
      _itineraries.insert(0, newItin);
      _notifications.insert(
        0,
        NotificationItem(
          id: 'notif_${DateTime.now().millisecondsSinceEpoch}',
          title: 'Agenda Baru Terdaftar',
          message:
              'Jadwal kunjungan ke ${newItin.destinationName} pada ${newItin.formattedDate} berhasil ditambahkan.',
          timestamp: DateTime.now(),
          type: NotificationType.schedule,
          isRead: false,
        ),
      );
    });
  }

  void _deleteItinerary(String id) {
    setState(() {
      _itineraries.removeWhere((item) => item.id == id);
    });
  }

  void _toggleCompleteItinerary(String id) {
    setState(() {
      final index = _itineraries.indexWhere((item) => item.id == id);
      if (index != -1) {
        _itineraries[index].isCompleted = !_itineraries[index].isCompleted;
      }
    });
  }

  void _markAllNotificationsRead() {
    setState(() {
      for (final n in _notifications) {
        n.isRead = true;
      }
    });
  }

  void _clearAllNotifications() {
    setState(() {
      _notifications.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomePage(
            onToggleSaved: _toggleSaved,
            isSaved: _isSaved,
            userLocation: _userLocation,
            onSelectLocation: _updateUserLocation,
            notifications: _notifications,
            onMarkAllNotificationsAsRead: _markAllNotificationsRead,
            onClearAllNotifications: _clearAllNotifications,
            onAddItinerary: _addItinerary,
            onNavigateToExplore: () => setState(() => _currentIndex = 1),
          ),
          ExplorePage(
            onToggleSaved: _toggleSaved,
            isSaved: _isSaved,
            userLocation: _userLocation,
            onAddItinerary: _addItinerary,
          ),
          ItineraryPage(
            itineraries: _itineraries,
            userLocation: _userLocation,
            onSelectLocation: _updateUserLocation,
            onAddItinerary: _addItinerary,
            onDeleteItinerary: _deleteItinerary,
            onToggleComplete: _toggleCompleteItinerary,
          ),
          SavedPage(
            savedIds: _savedIds,
            onToggleSaved: _toggleSaved,
            isSaved: _isSaved,
            userLocation: _userLocation,
            onAddItinerary: _addItinerary,
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.92),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavItem(
                    icon: Icons.home_rounded,
                    label: 'Beranda',
                    isActive: _currentIndex == 0,
                    onTap: () => setState(() => _currentIndex = 0),
                  ),
                  _NavItem(
                    icon: Icons.explore_outlined,
                    label: 'Eksplorasi',
                    isActive: _currentIndex == 1,
                    onTap: () => setState(() => _currentIndex = 1),
                  ),
                  _NavItem(
                    icon: Icons.calendar_month_rounded,
                    label: 'Jadwal',
                    isActive: _currentIndex == 2,
                    badgeCount: _itineraries
                        .where((i) => !i.isCompleted)
                        .length,
                    onTap: () => setState(() => _currentIndex = 2),
                  ),
                  _NavItem(
                    icon: Icons.bookmark_outline_rounded,
                    label: 'Tersimpan',
                    isActive: _currentIndex == 3,
                    badgeCount: _savedIds.length,
                    onTap: () => setState(() => _currentIndex = 3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final int? badgeCount;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    this.badgeCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal: isActive ? 16 : 8,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFFEEF2FF)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    icon,
                    size: 22,
                    color: isActive
                        ? const Color(0xFF4225D0)
                        : const Color(0xFF787587),
                  ),
                ),
                if (badgeCount != null && badgeCount! > 0)
                  Positioned(
                    top: 2,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Color(0xFF5B46E8),
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Center(
                        child: Text(
                          '$badgeCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive
                    ? const Color(0xFF4225D0)
                    : const Color(0xFF787587),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
