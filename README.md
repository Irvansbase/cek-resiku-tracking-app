# 📦 Cek Resiku - Flutter Resi Tracker App

Cek Resiku is a simple and modular Flutter application built to track shipment status using the [BinderByte API](https://binderbyte.com/). It's designed with a clean architecture and customizable structure, ideal for learning or commercial shipping tools.

---

## ✨ Features

- 🔍 Track shipment/resi from multiple couriers
- 🚚 Supports major Indonesian logistics (JNE, J&T, SiCepat, etc.)
- ⚙️ Built on **BinderByte's** fast and free API
- 🧩 Modular and easy-to-read file structure
- 📱 Responsive and smooth Flutter UI

---

## 🛠️ Tech Stack

- **Flutter** (Dart)
- **BinderByte API** (REST)

---

## 📂 Project Structure

lib/
├── config/ # App-wide constants
│ └── constants.dart
├── models/ # Data models
│ └── tracking_result.dart
├── pages/ # Screens
│ ├── home_page.dart
│ ├── result_page.dart
│ ├── scan_page.dart
│ └── splash_screen.dart
├── services/ # API calls and logic
│ └── tracking_service.dart
├── utils/ # Helper functions & logic
│ ├── helpers.dart
│ └── rewarded_ad_helper.dart
├── widgets/ # Reusable UI components
│ ├── ads.dart
│ └── tracking_form.dart
└── main.dart # App entry point


---

## 🔧 Getting Started

1. **Clone the repository**

git clone https://github.com/Irvansbase/cek-resiku-tracking-app.git

2. Install dependencies

flutter pub get

3. Setup BinderByte API Key

Register: https://binderbyte.com

Add your key in constants.dart:

const String binderbyteApiKey = "YOUR_API_KEY_HERE";


4. Run the app
 
flutter run

🧪 Sample Courier Codes
Courier	Code
JNE	jne
J&T Express	jnt
SiCepat	sicepat
AnterAja	anteraja
Ninja Xpress	ninja

📲 Screens Available
🏁 SplashScreen

📦 HomePage (form input & scan)

📊 ResultPage (resi result + detail)

📷 ScanPage (barcode scanner)

📢 Ads Integration
AdMob test ad units are already set up for:

Banner Ads

Rewarded Ads

Stored in:

lib/widgets/ads.dart
lib/utils/rewarded_ad_helper.dart


Change to your own AdMob ID before publishing.

🔐 License
This project is open source for learning and personal use.
For production, please follow BinderByte's API usage terms.

## 🙋 Author

Built with ❤️ by [Andriirv](https://github.com/Irvansbase)

- 📩 Email: irvans2731@gmail.com  
- 💬 WhatsApp: +62 821 2304 8478  
- 🌐 [Portfolio](https://www.andriirvansyah.vercel.app)

If you find this project helpful, please ⭐ the repo and share it!
