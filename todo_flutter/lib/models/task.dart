import 'package:intl/intl.dart';

class Task {
  final int? id;
  final String title;
  final DateTime dueDate;
  final bool isDone;
  final bool isImportant;
  final String? description;
  final DateTime? completedAt;

  Task({
    this.id,
    required this.title,
    required this.dueDate,
    this.isDone = false,
    this.isImportant = false,
    this.description,
    this.completedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    DateTime parseDate(String? raw) {
  if (raw == null) return DateTime.now();
  try {
    if (raw.length == 10 && raw.contains('-')) {
      // Format yyyy-MM-dd tanpa waktu
      final parts = raw.split('-');
      return DateTime(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
      );
    }
    // Default fallback pakai DateTime.parse (misal ISO8601 lengkap)
    return DateTime.parse(raw);
  } catch (_) {
    return DateTime.now();
  }
}

    return Task(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? ''),
      title: json['title'] ?? '',
      dueDate: parseDate(json['due_date']) ?? DateTime.now(),
      isDone: (json['is_done'] == 1 || json['is_done'] == true),
      isImportant: (json['is_important'] == 1 || json['is_important'] == true),
      description: json['description'],
      completedAt: parseDate(json['completed_at']),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'title': title,
      'due_date': DateFormat('yyyy-MM-dd').format(dueDate),
      'is_done': isDone ? 1 : 0,
      'is_important': isImportant ? 1 : 0,
      'description': description,
    };

    if (id != null) map['id'] = id;
    if (completedAt != null) {
      // Kirim completed_at cukup tanggal saja sesuai kebutuhan backend
      map['completed_at'] = DateFormat('yyyy-MM-dd').format(completedAt!);
    }

    return map;
  }

  // Getter tambahan untuk tampilan tanggal yang lebih rapi
  String get formattedDueDate => DateFormat('dd MMM yyyy').format(dueDate);

  String? get formattedCompletedAt =>
      completedAt != null ? DateFormat('dd MMM yyyy').format(completedAt!) : null;
}
