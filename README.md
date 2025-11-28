# FinLoop 💸

## The Architectonics of Tangible Value.

FinLoop is a next-generation personal finance ecosystem designed to bridge the gap between
functional utility and aesthetic comfort. It combines the tactile softness of Neumorphism (Soft UI)
with the rigor of minimalism to reduce cognitive load, making financial management intuitive and
engaging.

Unlike traditional banking apps, FinLoop integrates Gamification mechanics—allowing users to "Grow
their City" as they save and budget—transforming financial anxiety into mastery.

## 📱 Features

### 🔐 Multi-Method Authentication

* Secure login via Email/Password, Phone OTP, Google, Facebook, and Apple.
* Biometric security integration.

### 🎨 Adaptive Neumorphic Design

* Stunning "Soft UI" interface that provides tactile depth.
* Fully responsive Light, Dark, and Gold themes.
* Custom typography using Poppins & Inter for clarity and personality.

### 🎮 Financial Gamification

* Grow Your City: Visualizing wealth building as a digital city that expands with savings.
* Spin the Wheel: Daily engagement rewards.
* Tiers: Progression system (Free, Bronze, Silver, Gold, Platinum).

### 🌍 Localization

* Multi-language support (English & Spanish).
* Automated code generation for type-safe strings.

### 📊 Smart Analytics

* Visual breakdown of spending habits.
* "Spend Fearlessly" tracking logic.

## 🛠 Tech Stack

* Framework: Flutter (Mobile First)
* Language: Dart
* State Management: Flutter Bloc
* Navigation: GoRouter
* Dependency Injection: GetIt & Injectable
* Backend: Firebase (Auth, Firestore, Storage)
* Localization: flutter_localizations & intl with ARB files
* UI Libraries: flutter_neumorphic_plus, animate_do, fl_chart, google_fonts

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine.

### Prerequisites

* Flutter SDK (Version 3.10.x or higher)
* Firebase CLI
* Valid `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) placed in their
  respective directories.

## Installation

1. Clone the repository:

```
git clone [https://github.com/your-username/finloop.git](https://github.com/your-username/finloop.git)
cd finloop
```

2. Install dependencies:

```
flutter pub get
```

3. Environment Setup:
   Create a `.env` file in the root directory and populate it with your specific API keys and
   configuration URLs.

```
API_DOMAIN=api.yourdomain.com
# ... other keys
```

4. Generate Localization Files:
   This project uses ARB files for localization. You must generate the Dart files before running the
   app.

```
flutter gen-l10n
```

5. Run the App:

```
flutter run
```

## 📂 Project Structure

```
lib/
├── generated/       # Asset constants and generated files
├── l10n/            # Localization ARB files (app_en.arb, app_es.arb)
│   └── gen/         # Generated Localization Dart classes
├── logic/           # BLoCs and Cubits (State Management)
├── models/          # Data models (Auth, Config, User)
├── repositories/    # Data repositories (Auth, Config)
├── screens/         # UI Screens (Onboarding, Auth, Home, Splash)
├── services/        # Logic services (AuthService, AppStartService)
├── theme/           # App Theme definitions (Light, Dark, Fonts)
├── utils/           # Helper functions and constants
├── fin_loop_view.dart # Main App View
└── main.dart        # Entry point and initialization
```

## 🌍 Localization

To add a new language:

1. Create a new file in lib/l10n/ (e.g., app_fr.arb).
2. Copy the keys from app_en.arb and provide translations.
3. Run the generation command:

```
flutter gen-l10n
```

4. The new locale will be automatically supported by AppLocalizations.supportedLocales.

## 🤝 Contributing

1. Fork the Project

2. Create your Feature Branch (git checkout -b feature/AmazingFeature)

3. Commit your Changes (git commit -m 'Add some AmazingFeature')

4. Push to the Branch (`git push origin feature/Amazing