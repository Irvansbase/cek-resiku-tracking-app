import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ),
  );
}

String capitalize(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

// Di helpers.dart
String translateStatus(String status) {
  const translations = {
    'In Transit': 'Dalam Perjalanan',
    'Delivered': 'Terkirim',
    'Exception': 'Gangguan',
  };
  return translations[status] ?? status;
}

String convertToLocalTime(String dateTimeStr) {
  try {
    final utcTime = DateTime.parse(dateTimeStr).toUtc();
    final localTime = utcTime.toLocal();
    return DateFormat('dd/MM/yyyy HH:mm').format(localTime);
  } catch (e) {
    return dateTimeStr;
  }
}

Future<bool> requestCameraPermission() async {
  final status = await Permission.camera.status;
  
  if (status.isDenied) {
    final result = await Permission.camera.request();
    return result.isGranted;
  } else if (status.isPermanentlyDenied) {
    // Buka pengaturan jika izin ditolak permanen
    await openAppSettings();
    return false;
  }
  
  return status.isGranted;
}