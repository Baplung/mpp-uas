import 'package:flutter/material.dart';

enum NotificationType { weather, schedule, info }

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final NotificationType type;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    this.isRead = false,
  });

  IconData get icon {
    switch (type) {
      case NotificationType.weather:
        return Icons.cloud_queue_rounded;
      case NotificationType.schedule:
        return Icons.calendar_today_rounded;
      case NotificationType.info:
        return Icons.info_outline_rounded;
    }
  }

  Color get color {
    switch (type) {
      case NotificationType.weather:
        return const Color(0xFF0288D1);
      case NotificationType.schedule:
        return const Color(0xFF5B46E8);
      case NotificationType.info:
        return const Color(0xFF006C49);
    }
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Baru saja';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} mnt lalu';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} jam lalu';
    } else {
      return '${difference.inDays} hari lalu';
    }
  }
}
