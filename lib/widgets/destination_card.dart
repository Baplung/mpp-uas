import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/destination.dart';
import '../models/user_location.dart';

class DestinationCard extends StatelessWidget {
  final Destination destination;
  final bool isSaved;
  final VoidCallback onToggleSaved;
  final VoidCallback onTap;
  final UserLocation? userLocation;

  const DestinationCard({
    super.key,
    required this.destination,
    required this.isSaved,
    required this.onToggleSaved,
    required this.onTap,
    this.userLocation,
  });

  @override
  Widget build(BuildContext context) {
    final distanceText = userLocation?.formatDistanceTo(
      destination.latitude,
      destination.longitude,
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            SizedBox(
              height: 192,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    child: Image.asset(
                      destination.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Category tag
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: destination.categoryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        destination.category,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: destination.categoryTextColor,
                        ),
                      ),
                    ),
                  ),
                  // Bookmark button
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: onToggleSaved,
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.85),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isSaved
                                  ? Icons.bookmark_rounded
                                  : Icons.bookmark_border_rounded,
                              size: 18,
                              color: isSaved
                                  ? const Color(0xFF5B46E8)
                                  : const Color(0xFF474555),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Bottom badges on image: Duration & Weather
                  Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.55),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.access_time_rounded,
                                size: 12,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                destination.duration,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Weather badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.55),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                destination.weatherIcon,
                                size: 13,
                                color: Colors.amberAccent,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${destination.weatherCondition} • ${destination.weatherTemp}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating row & Distance badge
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 16,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${destination.rating}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111C2D),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${destination.reviews})',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF787587),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: destination.badgeColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          destination.badge,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: destination.badgeTextColor,
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (distanceText != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEF2FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.near_me_rounded,
                                size: 12,
                                color: Color(0xFF5B46E8),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                distanceText,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF5B46E8),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Title
                  Text(
                    destination.fullName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111C2D),
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Location
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: Color(0xFF787587),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        destination.location,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF787587),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Price section
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F3FF).withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
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
                                      fontSize: 14,
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF5B46E8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Detail',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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
}
