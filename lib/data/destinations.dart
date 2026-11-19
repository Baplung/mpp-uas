import 'package:flutter/material.dart';

import '../models/destination.dart';

final List<Destination> allDestinations = [
  Destination(
    id: 'bromo',
    name: 'Bromo',
    fullName: 'Taman Nasional Bromo Tengger Semeru',
    location: 'Probolinggo, Jawa Timur',
    category: 'Alam',
    rating: 4.9,
    reviews: '2.4rb ulasan',
    badge: 'Populer',
    price: 'Rp 275.000',
    priceUnit: '/ orang',
    duration: '1-2 Hari',
    imagePath: 'assets/images/bromo_choice.jpg',
    description:
        'Taman Nasional Bromo Tengger Semeru adalah salah satu destinasi alam paling ikonik di Indonesia. '
        'Terletak di Jawa Timur, taman nasional ini menawarkan pemandangan matahari terbit yang spektakuler '
        'di atas lautan pasir dengan latar Gunung Bromo yang masih aktif. Pengunjung dapat menikmati '
        'perjalanan jeep melintasi lautan pasir, mendaki ke kawah Bromo, serta menjelajahi keindahan '
        'Gunung Semeru, puncak tertinggi di Pulau Jawa.',
    categoryColor: const Color(0xF26FFBBE),
    categoryTextColor: const Color(0xFF002113),
    badgeColor: Color.fromRGBO(108, 248, 187, 0.4),
    badgeTextColor: const Color(0xFF006C49),
    latitude: -7.9425,
    longitude: 112.9530,
    weatherCondition: 'Kabut Sejuk',
    weatherTemp: '12°C',
    weatherIcon: Icons.cloud_outlined,
    weatherTips: 'Gunakan jaket tebal & syal, suhu pagi hari sangat dingin.',
  ),
  Destination(
    id: 'raja_ampat',
    name: 'Raja Ampat',
    fullName: 'Kepulauan Raja Ampat',
    location: 'Papua Barat Daya',
    category: 'Pantai',
    rating: 4.9,
    reviews: '1.8rb ulasan',
    badge: 'Pilihan Editor',
    price: 'Rp 3.850.000',
    priceUnit: '/ orang',
    duration: '3-5 Hari',
    imagePath: 'assets/images/pantai3warna.jpg',
    description:
        'Kepulauan Raja Ampat di Papua Barat Daya adalah surga bawah laut dengan keanekaragaman hayati '
        'laut tertinggi di dunia. Terdiri dari empat pulau besar dan ratusan pulau kecil, Raja Ampat '
        'menawarkan pengalaman menyelam dan snorkeling kelas dunia. Airnya yang jernih memperlihatkan '
        'terumbu karang berwarna-warni dan ribuan spesies ikan tropis.',
    categoryColor: const Color(0xF2DEE8FF),
    categoryTextColor: const Color(0xFF4225D0),
    badgeColor: Color.fromRGBO(228, 223, 255, 0.6),
    badgeTextColor: const Color(0xFF4225D0),
    latitude: -0.2333,
    longitude: 130.5167,
    weatherCondition: 'Cerah Bahari',
    weatherTemp: '30°C',
    weatherIcon: Icons.wb_sunny_rounded,
    weatherTips:
        'Kondisi ombak tenang, sangat ideal untuk snorkeling & diving.',
  ),
  Destination(
    id: 'penglipuran',
    name: 'Penglipuran',
    fullName: 'Desa Wisata Penglipuran',
    location: 'Bangli, Bali',
    category: 'Budaya',
    rating: 4.8,
    reviews: '3.1rb ulasan',
    badge: 'Heritage',
    price: 'Rp 50.000',
    priceUnit: '/ orang',
    duration: '3-4 Jam',
    imagePath: 'assets/images/kota_lama.jpg',
    description:
        'Desa Wisata Penglipuran di Bangli, Bali, adalah salah satu desa terbersih di dunia. '
        'Desa ini mempertahankan arsitektur tradisional Bali dengan tatanan rumah yang seragam '
        'dan jalan utama yang bersih tanpa kendaraan bermotor. Pengunjung dapat mempelajari '
        'kehidupan masyarakat Bali tradisional dan menikmati keindahan hutan bambu di sekitarnya.',
    categoryColor: const Color(0xF2FFDDB8),
    categoryTextColor: const Color(0xFF2A1700),
    badgeColor: Color.fromRGBO(255, 221, 184, 0.6),
    badgeTextColor: const Color(0xFF6B4200),
    latitude: -8.4526,
    longitude: 115.3556,
    weatherCondition: 'Cerah Berawan',
    weatherTemp: '25°C',
    weatherIcon: Icons.wb_cloudy_rounded,
    weatherTips: 'Udara perbukitan sejuk, sangat nyaman untuk jalan santai.',
  ),
  Destination(
    id: 'gudeg',
    name: 'Gudeg Yu Djum',
    fullName: 'Gudeg Yu Djum Wijilan',
    location: 'Yogyakarta',
    category: 'Kuliner',
    rating: 4.7,
    reviews: '5.2rb ulasan',
    badge: 'Legendaris',
    price: 'Rp 35.000',
    priceUnit: '/ porsi',
    duration: '1-2 Jam',
    imagePath: 'assets/images/kuliner.jpg',
    description:
        'Gudeg Yu Djum adalah legenda kuliner Yogyakarta yang telah berdiri sejak 1951. '
        'Terletak di kawasan Wijilan, warung ini menyajikan gudeg basah dan kering yang '
        'dimasak dengan resep turun-temurun. Cita rasa manis gurih khas gudeg Jogja '
        'dengan lauk lengkap seperti ayam kampung, telur, dan krecek menjadikannya '
        'destinasi wajib bagi pecinta kuliner nusantara.',
    categoryColor: const Color(0xF2FFDAD6),
    categoryTextColor: const Color(0xFF93000A),
    badgeColor: Color.fromRGBO(255, 218, 214, 0.6),
    badgeTextColor: const Color(0xFF93000A),
    latitude: -7.8052,
    longitude: 110.3644,
    weatherCondition: 'Panas Cerah',
    weatherTemp: '31°C',
    weatherIcon: Icons.wb_sunny_outlined,
    weatherTips:
        'Gunakan topi atau pelindung panas saat jalan-jalan di Wijilan.',
  ),
];
