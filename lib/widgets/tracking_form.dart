import 'package:cek_resi/config/constants.dart';
import 'package:cek_resi/pages/scan_page.dart';
import 'package:cek_resi/services/tracking_service.dart';
import 'package:cek_resi/utils/helpers.dart';
import 'package:cek_resi/utils/rewarded_ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class TrackingFormStateInterface {
  void setResiAndTrack(String resi);
}

class TrackingForm extends StatefulWidget {
  const TrackingForm({super.key});

  @override
  State<TrackingForm> createState() => TrackingFormState();
}

class TrackingFormState extends State<TrackingForm> implements TrackingFormStateInterface {
  final formKey = GlobalKey<FormState>();
  final _resiController = TextEditingController();
  String _selectedCourier = AppConstants.supportedCouriers.first;
  bool _isLoading = false;

  @override
  void dispose() {
    _resiController.dispose();
    super.dispose();
  }

  @override
  void setResiAndTrack(String resi) {
    _resiController.text = resi;

    Future.delayed(const Duration(milliseconds: 500), () {
      if (formKey.currentState!.validate()) {
        _trackPackage();
      }
    });
  }

  Future<void> _openScanner() async {
    final hasPermission = await requestCameraPermission();

    if (!hasPermission) {
      showSnackBar(context, 'Izin kamera diperlukan untuk scan barcode');
      return;
    }

    final resi = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const ScanPage()),
    );

    if (resi != null && resi.isNotEmpty) {
      setState(() => _resiController.text = resi);

      if (_resiController.text.length > 5) {
        // _trackPackage();
      }
    }
  }

  void _trackPackage() async {
  if (formKey.currentState!.validate()) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10,
        backgroundColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.blue.shade100, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.monetization_on, size: 48, color: Colors.blue.shade600),
              const SizedBox(height: 16),
              const Text(
                'Dukung Developer',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Untuk menutupi biaya API dan pemeliharaan, kami akan menampilkan iklan sebelum memproses pelacakan. Apakah Anda bersedia melanjutkan?',
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Batal',
                        style: TextStyle(color: Colors.black87, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Lanjut tampilkan iklan
                        RewardedAdHelper.showAd(
                          onAdDismissed: () => _processTracking(),
                          onAdFailed: (error) {
                            showSnackBar(context, 'Iklan gagal: $error');
                            _processTracking();
                          },
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Setuju',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


  Future<void> _processTracking() async {
    if (!mounted) return;
    
    setState(() => _isLoading = true);
    
    try {
      final result = await TrackingService.trackPackage(
        _resiController.text.trim(),
        _selectedCourier,
      );

      if (result != null && mounted) {
        Navigator.pushNamed(
          context,
          '/result',
          arguments: result,
        );
      } else {
        showSnackBar(context, 'Resi tidak ditemukan');
      }
    } catch (e) {
      showSnackBar(context, 'Terjadi kesalahan: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _resiController,
            decoration: InputDecoration(
              labelText: 'Nomor Resi',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.confirmation_number),
              suffixIcon: IconButton(
                icon: SvgPicture.asset(
                  'assets/images/scanner.svg',
                  width: 24,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: _openScanner,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Masukkan nomor resi';
              if (_selectedCourier == 'dhl' &&
                  !RegExp(r'^\d{10}$').hasMatch(value)) {
                return 'Format DHL: 10 digit angka';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            value: _selectedCourier,
            decoration: const InputDecoration(
              labelText: 'Pilih Kurir',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.local_shipping),
            ),
            items: AppConstants.supportedCouriers
                .map((courier) => DropdownMenuItem(
                      value: courier,
                      child: Text(
                          AppConstants.courierNames[courier] ?? courier.toUpperCase()),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() => _selectedCourier = value!);
            },
          ),
          const SizedBox(height: 30),
          _isLoading
              ? const SpinKitFadingCircle(color: Colors.blue, size: 50.0)
              : ElevatedButton.icon(
                  onPressed: _trackPackage,
                  label: const Text(
                    'Lacak Paket',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
        ],
      ),
    );
  }
}
