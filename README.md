# Weather App

A simple Flutter weather app that displays current weather details for a chosen location with a modern, card-based UI and a collapsible header showing current conditions.

## Features

- Current temperature, condition text and icon in a collapsible app bar
- A connected device or emulator
- Android SDK for Android builds

- lib/widgets/ — UI widgets (form, city item cards, grids)
- assets/images/ — sample weather images

- Keep images fetched via the API (network) safe by checking and prefixing the URL (e.g. use https: when needed).
- The project uses material_symbols_icons for compact icons.

- If the app won't start, run flutter doctor and resolve any missing dependencies.
- If network images don't appear, inspect the icon URL returned by the API. Some providers return protocol-relative paths (e.g. //...) — the code prefixes https: when required.

## Contributing

# Weather App

A visually stunning, modern Flutter application for real-time weather forecasting, location-based weather, and city favorites. Built with Riverpod for state management, custom UI widgets, and a harmonious color scheme for an exceptional user experience.

## Features

- *Location-Based Weather:* Automatically fetches and displays weather for your current location using device permissions.
- *City Search:* Search for any city worldwide and view detailed weather information.
- *7-Day Forecast:* Horizontally scrollable, interactive forecast cards for the next 7 days, including temperature, condition, and icons.
- *Favorites:* Add/remove cities to your favorites list. Favorite cities are displayed with animated icons and can be quickly accessed.
- *Modern UI:* Glassmorphism effects, gradients, blur, shadow, and responsive layouts. Custom bottom navigation bar and app bar for a seamless look.
- *Forecast Details:* Tap any forecast card to view detailed day, sun, and moon information in a beautiful bottom sheet.
- *Error & Loading States:* Animated, themed feedback for loading, errors, and empty states.
- *Accessibility:* Large fonts, high contrast, and responsive design for all devices.

## Screenshots

> Add screenshots here to showcase the UI and features.

## Technologies Used

- *Flutter* (Material 3, Riverpod)
- *Dart*
- *Google Fonts* (Poppins, Montserrat)
- *Custom Widgets* (WeatherCityItem, SliverOneGrid, SliverTwoGrid, WeatherSliverAppbar, ForecastdayBottomsheet, FavBottomsheet)

## Folder Structure


lib/
  main.dart
  models/
  providers/
  screens/
  services/
  widgets/
assets/
  images/


## How to Run

1. Clone the repository:
   sh
   git clone https://github.com/YunusMutlu/weather_App.git
   
2. Install dependencies:
   sh
   flutter pub get
   
3. Run the app:
   sh
   flutter run
   

## Customization

- Change the background image in assets/images/ for different weather conditions.
- Modify color schemes in main.dart for your own theme.
- Add more widgets or screens as needed.

## Credits

- Weather data powered by your chosen API (add details here).
- UI/UX inspired by modern design trends.

## License

MIT