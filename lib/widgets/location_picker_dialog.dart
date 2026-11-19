import 'package:flutter/material.dart';

import '../models/user_location.dart';

class LocationPickerSheet extends StatelessWidget {
  final UserLocation currentLocation;
  final ValueChanged<UserLocation> onSelectLocation;

  const LocationPickerSheet({
    super.key,
    required this.currentLocation,
    required this.onSelectLocation,
  });

  static Future<void> show(
    BuildContext context, {
    required UserLocation currentLocation,
    required ValueChanged<UserLocation> onSelectLocation,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => LocationPickerSheet(
        currentLocation: currentLocation,
        onSelectLocation: onSelectLocation,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: SafeArea(
        top: false,
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
            const SizedBox(height: 18),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.my_location_rounded,
                    color: Color(0xFF5B46E8),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pilih Lokasi Pengguna',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111C2D),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Jarak destinasi akan dihitung dinamis secara real-time',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF787587),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: availableLocations.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final loc = availableLocations[index];
                final isSelected = loc.id == currentLocation.id;

                return InkWell(
                  onTap: () {
                    onSelectLocation(loc);
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFEEF2FF)
                          : const Color(0xFFF9F9FF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF5B46E8)
                            : const Color(0xFFE5E7EB),
                        width: isSelected ? 1.5 : 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked_rounded
                              : Icons.radio_button_off_rounded,
                          color: isSelected
                              ? const Color(0xFF5B46E8)
                              : const Color(0xFF9E9E9E),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                loc.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: const Color(0xFF111C2D),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Lat: ${loc.latitude.toStringAsFixed(4)}, Long: ${loc.longitude.toStringAsFixed(4)}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF787587),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF5B46E8),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Aktif',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
