import 'dart:ui';

import 'package:flutter/material.dart';

import '../data/destinations.dart';
import '../models/itinerary.dart';
import '../models/notification_item.dart';
import '../models/user_location.dart';
import '../widgets/category_tile.dart';
import '../widgets/destination_card.dart';
import '../widgets/location_picker_dialog.dart';
import '../widgets/notifications_sheet.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  final void Function(String) onToggleSaved;
  final bool Function(String) isSaved;
  final UserLocation userLocation;
  final ValueChanged<UserLocation> onSelectLocation;
  final List<NotificationItem> notifications;
  final VoidCallback onMarkAllNotificationsAsRead;
  final VoidCallback onClearAllNotifications;
  final void Function(Itinerary) onAddItinerary;
  final VoidCallback onNavigateToExplore;

  const HomePage({
    super.key,
    required this.onToggleSaved,
    required this.isSaved,
    required this.userLocation,
    required this.onSelectLocation,
    required this.notifications,
    required this.onMarkAllNotificationsAsRead,
    required this.onClearAllNotifications,
    required this.onAddItinerary,
    required this.onNavigateToExplore,
  });

  @override
  Widget build(BuildContext context) {
    final unreadNotifCount = notifications.where((n) => !n.isRead).length;

    return CustomScrollView(
      slivers: [
        // Header
        SliverAppBar(
          pinned: true,
          floating: false,
          elevation: 0,
          scrolledUnderElevation: 0,
          toolbarHeight: 64,
          backgroundColor: const Color(0xFFF9F9FF).withValues(alpha: 0.8),
          flexibleSpace: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(color: Colors.transparent),
            ),
          ),
          title: const Row(
            children: [
              Icon(Icons.travel_explore, color: Color(0xFF5B46E8), size: 28),
              SizedBox(width: 8),
              Text(
                'LokaTrip',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111C2D),
                ),
              ),
            ],
          ),
          actions: [
            // Location badge selector button
            GestureDetector(
              onTap: () => LocationPickerSheet.show(
                context,
                currentLocation: userLocation,
                onSelectLocation: onSelectLocation,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF5B46E8).withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.near_me_rounded,
                      size: 14,
                      color: Color(0xFF5B46E8),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      userLocation.label,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4225D0),
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.arrow_drop_down,
                      size: 16,
                      color: Color(0xFF4225D0),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFFE4DFFF),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'G',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4225D0),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),

        // Body content
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // Greeting section with active notifications bell
                _buildGreetingSection(context, unreadNotifCount),

                const SizedBox(height: 20),

                // Hero banner
                _buildHeroBanner(context),

                const SizedBox(height: 24),

                // Bar info Lokasi Aktif & Cuaca Sekitar
                _buildLocationStatusBar(context),

                const SizedBox(height: 28),

                // Categories
                _buildCategoryHeader(),
              ],
            ),
          ),
        ),

        // Category tiles (horizontal scroll)
        SliverToBoxAdapter(
          child: SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: const [
                CategoryTile(
                  icon: Icons.forest_rounded,
                  label: 'Alam',
                  subtitle: 'Gunung & Hutan',
                  color: Color(0xFF6FFBBE),
                ),
                SizedBox(width: 12),
                CategoryTile(
                  icon: Icons.beach_access_rounded,
                  label: 'Pantai',
                  subtitle: 'Bahari & Pulau',
                  color: Color(0xFFDEE8FF),
                ),
                SizedBox(width: 12),
                CategoryTile(
                  icon: Icons.account_balance_rounded,
                  label: 'Budaya',
                  subtitle: 'Candi & Adat',
                  color: Color(0xFFFFDDB8),
                ),
                SizedBox(width: 12),
                CategoryTile(
                  icon: Icons.restaurant_rounded,
                  label: 'Kuliner',
                  subtitle: 'Otentik Lokal',
                  color: Color(0xFFFFDAD6),
                ),
              ],
            ),
          ),
        ),

        // Recommendation header
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 28, 20, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rekomendasi untukmu',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111C2D),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Jarak dihitung dinamis dari posisimu saat ini',
                  style: TextStyle(fontSize: 12, color: Color(0xFF474555)),
                ),
              ],
            ),
          ),
        ),

        // Destination cards
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final dest = allDestinations[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: DestinationCard(
                  destination: dest,
                  userLocation: userLocation,
                  isSaved: isSaved(dest.id),
                  onToggleSaved: () => onToggleSaved(dest.id),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(
                          destination: dest,
                          userLocation: userLocation,
                          isSaved: isSaved(dest.id),
                          onToggleSaved: () => onToggleSaved(dest.id),
                          onAddItinerary: onAddItinerary,
                        ),
                      ),
                    );
                  },
                ),
              );
            }, childCount: allDestinations.length),
          ),
        ),
      ],
    );
  }

  Widget _buildGreetingSection(BuildContext context, int unreadCount) {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Halo, selamat pagi 👋',
                style: TextStyle(fontSize: 12, color: Color(0xFF474555)),
              ),
              SizedBox(height: 4),
              Text(
                'Selamat datang, Ghazy',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111C2D),
                ),
              ),
            ],
          ),
        ),
        // Notification bell with interactive bottom sheet
        GestureDetector(
          onTap: () => NotificationsSheet.show(
            context,
            notifications: notifications,
            onMarkAllAsRead: onMarkAllNotificationsAsRead,
            onClearAll: onClearAllNotifications,
          ),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Center(
                  child: Icon(
                    Icons.notifications_none_rounded,
                    size: 24,
                    color: Color(0xFF474555),
                  ),
                ),
                if (unreadCount > 0)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Center(
                        child: Text(
                          '$unreadCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationStatusBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF5B46E8).withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.gps_fixed_rounded,
              color: Color(0xFF5B46E8),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Lokasi GPS Aktif',
                  style: TextStyle(fontSize: 10, color: Color(0xFF787587)),
                ),
                Text(
                  userLocation.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111C2D),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => LocationPickerSheet.show(
              context,
              currentLocation: userLocation,
              onSelectLocation: onSelectLocation,
            ),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Ubah',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF5B46E8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroBanner(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
            spreadRadius: -1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/bromo_dashboard.jpg', fit: BoxFit.cover),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.7),
                    Colors.black.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Pill tag
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Inspirasi Akhir Pekan',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Temukan tempat\nuntuk pulang',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Eksplorasi destinasi lokal favoritmu',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: onNavigateToExplore,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF5B46E8),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Mulai eksplorasi',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Kategori pilihan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111C2D),
          ),
        ),
        InkWell(
          onTap: onNavigateToExplore,
          child: const Text(
            'Lihat Semua',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF4225D0),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
