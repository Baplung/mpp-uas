import 'package:flutter/material.dart';

import '../data/destinations.dart';
import '../models/destination.dart';
import '../models/itinerary.dart';
import '../models/user_location.dart';

class ItineraryPage extends StatefulWidget {
  final List<Itinerary> itineraries;
  final UserLocation userLocation;
  final ValueChanged<UserLocation> onSelectLocation;
  final void Function(Itinerary) onAddItinerary;
  final void Function(String) onDeleteItinerary;
  final void Function(String) onToggleComplete;

  const ItineraryPage({
    super.key,
    required this.itineraries,
    required this.userLocation,
    required this.onSelectLocation,
    required this.onAddItinerary,
    required this.onDeleteItinerary,
    required this.onToggleComplete,
  });

  @override
  State<ItineraryPage> createState() => _ItineraryPageState();
}

class _ItineraryPageState extends State<ItineraryPage> {
  void _openAddItineraryDialog() {
    Destination selectedDest = allDestinations.first;
    DateTime selectedDate = DateTime.now().add(const Duration(days: 3));
    TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 30);
    final budgetController = TextEditingController(text: '350000');
    final notesController = TextEditingController(
      text: 'Membawa kamera & pakaian hangat',
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) {
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
            child: SingleChildScrollView(
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
                  const Row(
                    children: [
                      Icon(
                        Icons.add_task_rounded,
                        color: Color(0xFF5B46E8),
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Tambah Jadwal Kunjungan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111C2D),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Pilih Destinasi
                  const Text(
                    'Pilih Destinasi Wisata',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF474555),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F9FF),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Destination>(
                        value: selectedDest,
                        isExpanded: true,
                        items: allDestinations.map((d) {
                          return DropdownMenuItem(
                            value: d,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.asset(
                                    d.imagePath,
                                    width: 32,
                                    height: 32,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    d.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  d.category,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: d.categoryTextColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setModalState(() => selectedDest = val);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Tanggal & Jam
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tanggal Kunjungan',
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
                                  initialDate: selectedDate,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(
                                    const Duration(days: 365),
                                  ),
                                );
                                if (picked != null) {
                                  setModalState(() => selectedDate = picked);
                                }
                              },
                              borderRadius: BorderRadius.circular(14),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF9F9FF),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: const Color(0xFFE5E7EB),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month_rounded,
                                      size: 18,
                                      color: Color(0xFF5B46E8),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Waktu Keberangkatan',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF474555),
                              ),
                            ),
                            const SizedBox(height: 6),
                            InkWell(
                              onTap: () async {
                                final picked = await showTimePicker(
                                  context: ctx,
                                  initialTime: selectedTime,
                                );
                                if (picked != null) {
                                  setModalState(() => selectedTime = picked);
                                }
                              },
                              borderRadius: BorderRadius.circular(14),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF9F9FF),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: const Color(0xFFE5E7EB),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time_rounded,
                                      size: 18,
                                      color: Color(0xFF5B46E8),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')} WIB',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
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
                  const SizedBox(height: 14),

                  // Estimasi Budget
                  const Text(
                    'Estimasi Anggaran (Rp)',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF474555),
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: budgetController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Contoh: 500000',
                      prefixText: 'Rp ',
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
                  const SizedBox(height: 14),

                  // Catatan / Perlengkapan
                  const Text(
                    'Catatan / Perlengkapan',
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
                      hintText: 'Catatan barang bawaan atau agenda khusus...',
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

                  // Tombol Simpan Jadwal
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final parsedBudget =
                            int.tryParse(budgetController.text) ?? 250000;
                        final newItinerary = Itinerary(
                          id: 'itin_${DateTime.now().millisecondsSinceEpoch}',
                          destinationId: selectedDest.id,
                          destinationName: selectedDest.fullName,
                          destinationImage: selectedDest.imagePath,
                          location: selectedDest.location,
                          visitDate: selectedDate,
                          visitTime:
                              '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')} WIB',
                          estimatedBudget: parsedBudget,
                          notes: notesController.text.trim().isEmpty
                              ? 'Tidak ada catatan tambahan'
                              : notesController.text.trim(),
                        );

                        widget.onAddItinerary(newItinerary);
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Jadwal ke ${selectedDest.name} berhasil disimpan!',
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
                        'Simpan ke Jadwal Saya',
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
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = widget.itineraries
        .where((i) => i.isCompleted)
        .length;
    final totalBudget = widget.itineraries.fold<int>(
      0,
      (sum, item) => sum + item.estimatedBudget,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rencana Wisata',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF111C2D),
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Atur jadwal & agenda perjalanan secara dinamis',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF787587),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: _openAddItineraryDialog,
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF5B46E8),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF5B46E8)
                                      .withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Tambah',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Ringkasan Statistik
                    Row(
                      children: [
                        _buildStatBox(
                          icon: Icons.calendar_today_rounded,
                          color: const Color(0xFF5B46E8),
                          value: '${widget.itineraries.length}',
                          label: 'Total Jadwal',
                        ),
                        const SizedBox(width: 10),
                        _buildStatBox(
                          icon: Icons.check_circle_outline_rounded,
                          color: const Color(0xFF006C49),
                          value: '$completedCount',
                          label: 'Terkunjungi',
                        ),
                        const SizedBox(width: 10),
                        _buildStatBox(
                          icon: Icons.account_balance_wallet_outlined,
                          color: const Color(0xFFE65100),
                          value: _formatCompactNumber(totalBudget),
                          label: 'Est. Biaya',
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Bar Lokasi Dinamis Pengguna
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.my_location_rounded,
                            color: Color(0xFF5B46E8),
                            size: 18,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Basis Lokasi Kamu',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF787587),
                                  ),
                                ),
                                Text(
                                  widget.userLocation.name,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF111C2D),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEEF2FF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Realtime GPS',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF4225D0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // List Itinerary
            widget.itineraries.isEmpty
                ? SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map_outlined,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Belum Ada Jadwal Wisata',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111C2D),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Mulai susun rencana liburan impianmu\ndengan menekan tombol Tambah di atas',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF787587),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final item = widget.itineraries[index];
                        final dest = allDestinations.firstWhere(
                          (d) => d.id == item.destinationId,
                          orElse: () => allDestinations.first,
                        );

                        final distanceStr = widget.userLocation
                            .formatDistanceTo(dest.latitude, dest.longitude);

                        return Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            border: Border.all(
                              color: item.isCompleted
                                  ? const Color(0xFF006C49)
                                        .withValues(alpha: 0.3)
                                  : Colors.transparent,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Top image & Destination title
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      item.destinationImage,
                                      height: 100,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Colors.black.withValues(
                                              alpha: 0.75,
                                            ),
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      left: 12,
                                      right: 12,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.destinationName,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  '${item.location} • $distanceStr',
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.white70,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withValues(
                                                alpha: 0.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  dest.weatherIcon,
                                                  color: Colors.amberAccent,
                                                  size: 12,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  dest.weatherTemp,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600,
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

                              // Info content
                              Padding(
                                padding: const EdgeInsets.all(14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.calendar_today_rounded,
                                                size: 13,
                                                color: Color(0xFF5B46E8),
                                              ),
                                              const SizedBox(width: 6),
                                              Flexible(
                                                child: Text(
                                                  '${item.formattedDate} • ${item.visitTime}',
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF111C2D),
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          item.formattedBudget,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF4225D0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),

                                    // Catatan
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF9F9FF),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.sticky_note_2_outlined,
                                            size: 14,
                                            color: Color(0xFF787587),
                                          ),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: Text(
                                              item.notes,
                                              style: const TextStyle(
                                                fontSize: 11,
                                                color: Color(0xFF474555),
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),

                                    // Action buttons: Toggle Complete & Delete
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () =>
                                              widget.onToggleComplete(item.id),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                item.isCompleted
                                                    ? Icons.check_box_rounded
                                                    : Icons
                                                          .check_box_outline_blank_rounded,
                                                size: 20,
                                                color: item.isCompleted
                                                    ? const Color(0xFF006C49)
                                                    : const Color(0xFF787587),
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                item.isCompleted
                                                    ? 'Sudah Dikunjungi'
                                                    : 'Tandai Selesai',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: item.isCompleted
                                                      ? const Color(0xFF006C49)
                                                      : const Color(0xFF474555),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete_outline_rounded,
                                            size: 18,
                                            color: Color(0xFFEF4444),
                                          ),
                                          onPressed: () =>
                                              widget.onDeleteItinerary(item.id),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }, childCount: widget.itineraries.length),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBox({
    required IconData icon,
    required Color color,
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111C2D),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Color(0xFF787587)),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCompactNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)} jt';
    } else if (number >= 1000) {
      return '${(number / 1000).round()} rb';
    } else {
      return number.toString();
    }
  }
}
