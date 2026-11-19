import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/destination.dart';
import '../models/itinerary.dart';
import '../models/user_location.dart';

class DetailPage extends StatelessWidget {
  final Destination destination;
  final bool isSaved;
  final VoidCallback onToggleSaved;
  final UserLocation userLocation;
  final void Function(Itinerary)? onAddItinerary;

  const DetailPage({
    super.key,
    required this.destination,
    required this.isSaved,
    required this.onToggleSaved,
    required this.userLocation,
    this.onAddItinerary,
  });

  void _showBookingDialog(BuildContext context) {
    DateTime visitDate = DateTime.now().add(const Duration(days: 2));
    final budgetController = TextEditingController(
      text: '${destination.price.replaceAll(RegExp(r'[^0-9]'), '')}000',
    );
    final notesController = TextEditingController(
      text: 'Eksplorasi seru LokaTrip',
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            padding: EdgeInsets.fromLTRB(
              20,
              16,
              20,
              MediaQuery.of(ctx).viewInsets.bottom + 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.airplane_ticket_rounded,
                        color: Color(0xFF5B46E8),
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Jadwalkan Kunjungan',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111C2D),
                            ),
                          ),
                          Text(
                            destination.name,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF787587),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Tanggal Keberangkatan',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF474555),
                  ),
                ),
                const SizedBox(height: 6),
                InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: ctx,
                      initialDate: visitDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) {
                      setSheetState(() => visitDate = picked);
                    }
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F9FF),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_rounded,
                          color: Color(0xFF5B46E8),
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${visitDate.day}/${visitDate.month}/${visitDate.year}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Catatan Rencana Perjalanan',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF474555),
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: notesController,
                  decoration: InputDecoration(
                    hintText: 'Misal: Beli tiket online dan sewa jeep...',
                    filled: true,
                    fillColor: const Color(0xFFF9F9FF),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (onAddItinerary != null) {
                        final rawBudget =
                            int.tryParse(budgetController.text) ?? 300000;
                        onAddItinerary!(
                          Itinerary(
                            id: 'itin_${DateTime.now().millisecondsSinceEpoch}',
                            destinationId: destination.id,
                            destinationName: destination.fullName,
                            destinationImage: destination.imagePath,
                            location: destination.location,
                            visitDate: visitDate,
                            visitTime: '08:00 WIB',
                            estimatedBudget: rawBudget,
                            notes: notesController.text.trim().isEmpty
                                ? 'Kunjungan wisata terencana'
                                : notesController.text.trim(),
                          ),
                        );
                      }
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Agenda ke ${destination.name} berhasil ditambahkan ke Rencana Wisata!',
                          ),
                          backgroundColor: const Color(0xFF5B46E8),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5B46E8),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Konfirmasi & Tambah ke Jadwal',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final distanceText = userLocation.formatDistanceTo(
      destination.latitude,
      destination.longitude,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Hero image
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 340,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(destination.imagePath, fit: BoxFit.cover),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.6),
                              Colors.black.withValues(alpha: 0.0),
                            ],
                          ),
                        ),
                      ),
                      // Top buttons
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _circleButton(
                                icon: Icons.arrow_back_rounded,
                                onTap: () => Navigator.pop(context),
                              ),
                              Row(
                                children: [
                                  _circleButton(
                                    icon: Icons.share_outlined,
                                    onTap: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Membagikan info ${destination.name}...',
                                          ),
                                          duration: const Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  _circleButton(
                                    icon: isSaved
                                        ? Icons.bookmark_rounded
                                        : Icons.bookmark_border_rounded,
                                    onTap: onToggleSaved,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Bottom pills on image
                      Positioned(
                        bottom: 16,
                        left: 16,
                        child: Row(
                          children: [
                            _imagePill(
                              icon: Icons.location_on_outlined,
                              text: destination.location,
                            ),
                            const SizedBox(width: 8),
                            _imagePill(
                              icon: Icons.access_time_rounded,
                              text: destination.duration,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        destination.fullName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111C2D),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Location with dynamic GPS distance
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Color(0xFF787587),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${destination.location} (sekitar $distanceText dari ${userLocation.label})',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF787587),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Info pills
                      SizedBox(
                        height: 34,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _infoPill(destination.category),
                            const SizedBox(width: 8),
                            _infoPill(destination.duration),
                            const SizedBox(width: 8),
                            _infoPill(destination.badge),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Stat cards (with real calculated dynamic distance)
                      Row(
                        children: [
                          _statCard(
                            icon: Icons.star_rounded,
                            iconColor: Colors.amber,
                            value: destination.rating.toString(),
                            label: destination.reviews,
                          ),
                          const SizedBox(width: 12),
                          _statCard(
                            icon: Icons.schedule_rounded,
                            iconColor: const Color(0xFF5B46E8),
                            value: destination.duration,
                            label: 'Durasi',
                          ),
                          const SizedBox(width: 12),
                          _statCard(
                            icon: Icons.near_me_rounded,
                            iconColor: const Color(0xFF006C49),
                            value: distanceText,
                            label: 'Jarak GPS',
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Fitur Tambahan UAS: Prakiraan Cuaca Destinasi Dinamis
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFEEF2FF), Color(0xFFE0E7FF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFF5B46E8)
                                .withValues(alpha: 0.2),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      destination.weatherIcon,
                                      color: const Color(0xFF5B46E8),
                                      size: 24,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Prakiraan Cuaca Lokal',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF111C2D),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '${destination.weatherCondition} • ${destination.weatherTemp}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF5B46E8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.tips_and_updates_outlined,
                                  size: 16,
                                  color: Color(0xFF006C49),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    destination.weatherTips,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF374151),
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                      // About
                      const Text(
                        'Tentang Destinasi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111C2D),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        destination.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF474555),
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Fixed bottom bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Mulai dari',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF474555),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  destination.price,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF4225D0),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  destination.priceUnit,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF787587),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _showBookingDialog(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5B46E8),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Jadwalkan Tour',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 22, color: const Color(0xFF111C2D)),
          ),
        ),
      ),
    );
  }

  Widget _imagePill({required IconData icon, required String text}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: Colors.white),
              const SizedBox(width: 4),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF4225D0),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _statCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 22, color: iconColor),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111C2D),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: Color(0xFF787587)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
