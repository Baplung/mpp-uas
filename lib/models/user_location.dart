import 'dart:math';

class UserLocation {
  final String id;
  final String name;
  final String label;
  final double latitude;
  final double longitude;

  const UserLocation({
    required this.id,
    required this.name,
    required this.label,
    required this.latitude,
    required this.longitude,
  });

  /// Menghitung jarak ke destinasi menggunakan Haversine Formula dalam kilometer (km)
  double distanceTo(double destLat, double destLng) {
    const double earthRadiusKm = 6371.0;

    final double dLat = _degToRad(destLat - latitude);
    final double dLng = _degToRad(destLng - longitude);

    final double a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(latitude)) *
            cos(_degToRad(destLat)) *
            sin(dLng / 2) *
            sin(dLng / 2);

    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusKm * c;
  }

  /// Menghasilkan string jarak yang diformat ramah pengguna
  String formatDistanceTo(double destLat, double destLng) {
    final double distanceKm = distanceTo(destLat, destLng);
    if (distanceKm < 1.0) {
      return '${(distanceKm * 1000).round()} m';
    } else if (distanceKm < 100.0) {
      return '${distanceKm.toStringAsFixed(1)} km';
    } else {
      return '${distanceKm.round()} km';
    }
  }

  static double _degToRad(double degree) {
    return degree * (pi / 180.0);
  }
}

/// Daftar pilihan lokasi simulasi pengguna untuk pengujian lokasi dinamis
final List<UserLocation> availableLocations = [
  const UserLocation(
    id: 'malang_uin',
    name: 'Malang (UIN Maulana Malik Ibrahim)',
    label: 'UIN Malang',
    latitude: -7.9525,
    longitude: 112.6145,
  ),
  const UserLocation(
    id: 'surabaya',
    name: 'Surabaya (Pusat Kota)',
    label: 'Surabaya',
    latitude: -7.2575,
    longitude: 112.7521,
  ),
  const UserLocation(
    id: 'yogyakarta',
    name: 'Yogyakarta (Malioboro)',
    label: 'Yogyakarta',
    latitude: -7.7956,
    longitude: 110.3695,
  ),
  const UserLocation(
    id: 'denpasar',
    name: 'Denpasar (Bali)',
    label: 'Denpasar',
    latitude: -8.6705,
    longitude: 115.2126,
  ),
  const UserLocation(
    id: 'jakarta',
    name: 'Jakarta (Monas)',
    label: 'Jakarta',
    latitude: -6.1754,
    longitude: 106.8272,
  ),
];
