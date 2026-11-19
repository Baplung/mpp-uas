class Itinerary {
  final String id;
  final String destinationId;
  final String destinationName;
  final String destinationImage;
  final String location;
  final DateTime visitDate;
  final String visitTime;
  final int estimatedBudget;
  final String notes;
  bool isCompleted;
  final DateTime createdAt;

  Itinerary({
    required this.id,
    required this.destinationId,
    required this.destinationName,
    required this.destinationImage,
    required this.location,
    required this.visitDate,
    required this.visitTime,
    required this.estimatedBudget,
    required this.notes,
    this.isCompleted = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  String get formattedDate {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${visitDate.day} ${months[visitDate.month - 1]} ${visitDate.year}';
  }

  String get formattedBudget {
    final buffer = StringBuffer();
    final str = estimatedBudget.toString();
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      buffer.write(str[i]);
      count++;
      if (count % 3 == 0 && i > 0) {
        buffer.write('.');
      }
    }
    return 'Rp ${buffer.toString().split('').reversed.join('')}';
  }
}
