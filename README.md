# Country List App

A Flutter mobile application that allows users to view information about different countries, including details like states, country codes, flags, and capitals. The app features both light and dark theme modes and is built using Flutter/Dart.


![App Demo](https://github.com/d3mastermind/globalia/blob/main/Media/Screen_Recording.gif)

[🎥 Watch the full demo](https://github.com/d3mastermind/globalia/blob/4178ac3cd95719c5e1911a4788776f31bcb5a331/Media/Screen_Recording.mp4)


## Features

- View a comprehensive list of countries
- Search functionality to filter countries by name
- Detailed country information including:
  - Country name
  - Flag
  - Population
  - Capital city
  - Continent
  - Country code
  - Time Zone
- Theme customization (Light/Dark mode)
- Responsive design for various screen sizes

## Live Demo

Try the app directly in your browser using Appetize.io:
[Live Demo Link](https://appetize.io/app/b_r3pqzu5zr2wqabyams7jg34klm)

## Download APK

You can download the latest APK from the [releases section](https://github.com/d3mastermind/globalia/tree/4178ac3cd95719c5e1911a4788776f31bcb5a331/APK)


## Installation

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio or VS Code with Flutter extensions
- An Android or iOS device/emulator

### Getting Started

1. Clone the repository:
```bash
git clone https://github.com/yourusername/country-list-app.git
cd country-list-app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Dependencies

- **http**: ^1.3.0 - For making HTTP requests to the REST API
- Other Flutter default dependencies

## API Reference

This app uses the REST Countries API to fetch country data:
- Base URL: https://restcountries.com/v3.1
- Endpoint for all countries: `/all`


## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Build and Deploy

To build the release APK:

```bash
flutter build apk --release
```

The APK will be available at `build/app/outputs/flutter-apk/app-release.apk`


## Acknowledgments

- [REST Countries API](https://restcountries.com/) for providing the country data
- Flutter team for the amazing framework
- [HNG Internship](https://hng.tech/internship)