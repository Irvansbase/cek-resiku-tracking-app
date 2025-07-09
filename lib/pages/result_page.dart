import 'package:cek_resi/config/constants.dart';
import 'package:cek_resi/models/tracking_result.dart';
import 'package:cek_resi/utils/helpers.dart';
import 'package:cek_resi/utils/rewarded_ad_helper.dart';
import 'package:cek_resi/widgets/ads.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultPage extends StatelessWidget {
  final TrackingResult result;

  const ResultPage({super.key, required this.result});

  @override
Widget build(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
  RewardedAdHelper.loadAd(); // Muat untuk penggunaan berikutnya
    });
  return Scaffold(
    appBar: AppBar(
      title: const Text('Hasil Pelacakan'),
      centerTitle: true,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderCard(),
          const SizedBox(height: 20), 
          const SizedBox(height: 20),
          _buildHistoryList(), // tidak lagi dalam Expanded
        ],
      ),
    ),
  );
}


  Widget _buildHeaderCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const NativeExample(),
            const SizedBox(height: 20),
            SizedBox(height: 0,),
            _infoRow('Resi', result.resi),
            _infoRow('Kurir', AppConstants.courierNames[result.courier] ?? result.courier),
            _infoRow('Layanan', result.service ?? '-'),
            const Divider(),
            _infoRow('Asal', result.origin ?? '-'),
            _infoRow('Tujuan', result.destination ?? '-'),
            const Divider(),
            _infoRow('Pengirim', result.shipper ?? '-'),
            _infoRow('Penerima', result.receiver ?? '-'),
            const SizedBox(height: 10),
            Text(
              'Status: ${translateStatus(result.status)}',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.green[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          Expanded(
            child: Text(value,
                style: GoogleFonts.poppins(color: Colors.grey[700])),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
  if (result.history.isEmpty) {
    return Center(
      child: Text(
        'Tidak ada riwayat pengiriman.',
        style: GoogleFonts.poppins(fontSize: 16),
      ),
    );
  }

  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: result.history.length,
    itemBuilder: (context, index) {
      final item = result.history[index];
      return Card(
        elevation: 2,
        margin: const EdgeInsets.only(bottom: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: const Icon(Icons.local_shipping, color: Colors.blue),
          title: Text(
            item.description,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            '${item.date.day}/${item.date.month}/${item.date.year} '
            '${item.date.hour.toString().padLeft(2, '0')}:${item.date.minute.toString().padLeft(2, '0')}',
            style: GoogleFonts.poppins(fontSize: 12),
          ),
          trailing: Text(
            item.location,
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700]),
          ),
        ),
      );
    },
  );
}

}
