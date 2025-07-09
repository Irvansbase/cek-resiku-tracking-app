// lib/models/tracking_result.dart
class TrackingResult {
  final String status;
  final String courier;
  final String resi;
  final List<TrackingDetail> history;
  final String? service;
  final String? origin;
  final String? destination;
  final String? shipper;
  final String? receiver;

  TrackingResult({
    required this.status,
    required this.courier,
    required this.resi,
    required this.history,
    this.service,
    this.origin,
    this.destination,
    this.shipper,
    this.receiver,
  });

  factory TrackingResult.fromBinderbyteJson(Map<String, dynamic> json) {
    final data = json['data'];
    final summary = data['summary'] ?? {};
    final history = data['history'] as List? ?? [];

    return TrackingResult(
      status: summary['status'] ?? 'Unknown',
      courier: summary['courier'] ?? '',
      resi: summary['awb'] ?? '',
      service: summary['service'],
      origin: data['detail']?['origin'],
      destination: data['detail']?['destination'],
      shipper: data['detail']?['shipper'],
      receiver: data['detail']?['receiver'],
      history: history.map((item) => TrackingDetail.fromJson(item)).toList(),
    );
  }
}

// Kelas TrackingDetail harus didefinisikan secara terpisah
class TrackingDetail {
  final DateTime date;
  final String description;
  final String location;

  TrackingDetail({
    required this.date,
    required this.description,
    required this.location,
  });

  factory TrackingDetail.fromJson(Map<String, dynamic> json) {
    return TrackingDetail(
      date: DateTime.parse(json['date']),
      description: json['desc'] ?? '',
      location: json['location'] ?? '',
    );
  }
}