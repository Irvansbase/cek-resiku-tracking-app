import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  MobileScannerController cameraController = MobileScannerController();
  String? scannedData;

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }

  Future<void> _checkCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
      if (!status.isGranted) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Izin kamera diperlukan untuk scan')),
          );
          Navigator.pop(context); // keluar jika tidak ada izin
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Barcode'),
        actions: [
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            onPressed: () => cameraController.toggleTorch(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null && scannedData == null) {
                  setState(() {
                    scannedData = barcode.rawValue!;
                  });

                  Future.delayed(const Duration(milliseconds: 500), () {
                    if (mounted && Navigator.canPop(context)) {
                      Navigator.pop(context, scannedData);
                    }
                  });
                }
              }
            },
          ),
          CustomPaint(
            painter: BarcodeOverlay(scannedData: scannedData),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}

class BarcodeOverlay extends CustomPainter {
  final String? scannedData;

  BarcodeOverlay({this.scannedData});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = scannedData == null ? Colors.red : Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final width = size.width * 0.8;
    final height = size.height * 0.3;
    final left = (size.width - width) / 2;
    final top = (size.height - height) / 2;

    // Kotak panduan scan
    canvas.drawRect(
      Rect.fromLTRB(left, top, left + width, top + height),
      paint,
    );

    // Tampilkan hasil scan jika ada
    if (scannedData != null) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: 'Resi: $scannedData',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            backgroundColor: Colors.black54,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          (size.width - textPainter.width) / 2,
          top + height + 20,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
