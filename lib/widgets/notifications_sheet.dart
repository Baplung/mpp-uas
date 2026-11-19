import 'package:flutter/material.dart';

import '../models/notification_item.dart';

class NotificationsSheet extends StatelessWidget {
  final List<NotificationItem> notifications;
  final VoidCallback onMarkAllAsRead;
  final VoidCallback onClearAll;

  const NotificationsSheet({
    super.key,
    required this.notifications,
    required this.onMarkAllAsRead,
    required this.onClearAll,
  });

  static Future<void> show(
    BuildContext context, {
    required List<NotificationItem> notifications,
    required VoidCallback onMarkAllAsRead,
    required VoidCallback onClearAll,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => NotificationsSheet(
        notifications: notifications,
        onMarkAllAsRead: onMarkAllAsRead,
        onClearAll: onClearAll,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: SafeArea(
        top: false,
        child: Column(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.notifications_active_rounded,
                        color: Color(0xFF5B46E8),
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pemberitahuan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF111C2D),
                          ),
                        ),
                        Text(
                          '${notifications.where((n) => !n.isRead).length} pesan belum dibaca',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF787587),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.done_all_rounded, size: 20),
                      tooltip: 'Tandai semua dibaca',
                      color: const Color(0xFF5B46E8),
                      onPressed: onMarkAllAsRead,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline_rounded, size: 20),
                      tooltip: 'Bersihkan semua',
                      color: const Color(0xFFEF4444),
                      onPressed: onClearAll,
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 24),
            Expanded(
              child: notifications.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_off_outlined,
                            size: 48,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Belum ada notifikasi',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF474555),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Informasi cuaca dan jadwal kunjungan akan muncul di sini',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF787587),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      itemCount: notifications.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final notif = notifications[index];
                        return Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: notif.isRead
                                ? const Color(0xFFF9F9FF)
                                : const Color(0xFFEEF2FF)
                                      .withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: notif.isRead
                                  ? const Color(0xFFE5E7EB)
                                  : const Color(0xFF5B46E8)
                                        .withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: notif.color.withValues(alpha: 0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  notif.icon,
                                  color: notif.color,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            notif.title,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: notif.isRead
                                                  ? FontWeight.w600
                                                  : FontWeight.w700,
                                              color: const Color(0xFF111C2D),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          notif.timeAgo,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Color(0xFF787587),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      notif.message,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF474555),
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
