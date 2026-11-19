import 'package:flutter/material.dart';

class Destination {
  final String id;
  final String name;
  final String fullName;
  final String location;
  final String category;
  final double rating;
  final String reviews;
  final String badge;
  final String price;
  final String priceUnit;
  final String duration;
  final String imagePath;
  final String description;
  final Color categoryColor;
  final Color categoryTextColor;
  final Color badgeColor;
  final Color badgeTextColor;

  // Atribut Tambahan UAS: Lokasi Dinamis & Perkiraan Cuaca
  final double latitude;
  final double longitude;
  final String
  weatherCondition; // e.g. "Cerah Berawan", "Hujan Ringan", "Cerah"
  final String weatherTemp; // e.g. "12°C", "29°C", "24°C"
  final IconData weatherIcon;
  final String weatherTips;

  const Destination({
    required this.id,
    required this.name,
    required this.fullName,
    required this.location,
    required this.category,
    required this.rating,
    required this.reviews,
    required this.badge,
    required this.price,
    required this.priceUnit,
    required this.duration,
    required this.imagePath,
    required this.description,
    required this.categoryColor,
    required this.categoryTextColor,
    required this.badgeColor,
    required this.badgeTextColor,
    required this.latitude,
    required this.longitude,
    required this.weatherCondition,
    required this.weatherTemp,
    required this.weatherIcon,
    required this.weatherTips,
  });
}
