class AppConstants {
  static const List<String> supportedCouriers = [
    'jne',
    'pos',
    'jnt',
    'jnt_cargo',
    'spx',
    'sicepat',
    'tiki',
    'anteraja',
    'wahana',
    'ninja',
    'lion',
    'pcp',
    'jet',
    'rex',
    'first',
    'ide',
    'kgx',
    'sap',
    'rpx',
    'lex',
    'indah_cargo',
    'dakota',
    'kurir_tokopedia',
  ];

  static const Map<String, String> courierNames = {
    // Domestik Utama
  'jne': 'JNE',
  'pos': 'POS Indonesia',
  'jnt': 'J&T Express',
  'jnt_cargo': 'J&T Cargo',
  'sicepat': 'SiCepat',
  'tiki': 'TIKI',
  'anteraja': 'AnterAja',
  'wahana': 'Wahana Express',
  'ninja': 'Ninja Express',
  'lion': 'Lion Parcel',
  'pcp': 'PCP Express',
  'jet': 'JET Express',
  'rex': 'REX Express',
  'first': 'First Logistics',
  'ide': 'ID Express',
  'spx': 'Shopee Express',
  'kgx': 'KGXpress',
  'sap': 'SAP Express',
  'rpx': 'RPX',
  'lex': 'Lazada Express',
  'indah_cargo': 'Indah Cargo',
  'dakota': 'Dakota Cargo',
  'kurir_tokopedia': 'Kurir Rekomendasi Tokopedia',
  };

  static const String apiKey =
      '023c04982569fa341dc70a6b45b0609a6dea934b62c91fdca2e2615ee6c7581b';
  static const String apiUrl = 'https://api.binderbyte.com/v1/track';
}
