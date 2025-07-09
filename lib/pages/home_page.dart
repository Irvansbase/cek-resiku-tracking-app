import 'package:flutter/material.dart';
import 'package:cek_resi/widgets/tracking_form.dart';
import 'package:cek_resi/pages/scan_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<TrackingFormState> trackingFormKey = GlobalKey();

  void _openScanner() async {
    final resi = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const ScanPage()),
    );

    if (!mounted) return;

    if (resi != null && resi.isNotEmpty) {
      trackingFormKey.currentState?.setResiAndTrack(resi);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cek Resi Pengiriman', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, size: 28),
            onPressed: _openScanner,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header dengan logo
                    
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                        'assets/images/logos.png',
                        height: 150,
                          ),
                          const Text(
                            'Lacak Pengiriman Anda',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Masukkan nomor resi dan pilih kurir untuk memulai pelacakan',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Form pelacakan
                    TrackingForm(key: trackingFormKey),
                    const SizedBox(height: 10),
                    
                    // Fitur tambahan
                    
                    const SizedBox(height: 30),
                    
                    // Panduan penggunaan
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Cara Melacak Resi',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildGuideStep(1, 'Masukkan nomor resi pengiriman'),
                          _buildGuideStep(2, 'Pilih jasa kurir yang digunakan'),
                          _buildGuideStep(3, 'Tekan tombol "Lacak Paket"'),
                          _buildGuideStep(4, 'Atau gunakan fitur scan barcode'),
                          _buildGuideStep(5, 'Menonton iklan membantu mendukung biaya server & API agar aplikasi ini tetap gratis untuk digunakan.'),
                          _buildGuideStep(6, '+62 821 2304 8478 Whatsapp, Hubungi jika terdapat Bug, Saran dan Masukan.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildGuideStep(int number, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

