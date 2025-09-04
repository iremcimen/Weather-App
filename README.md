# Weather App

A simple Flutter weather app that displays current weather details for a chosen location with a modern, card-based UI and a collapsible header showing current conditions.

## Features

- Current temperature, condition text and icon in a collapsible app bar
- Detail cards showing feels-like, humidity, UV index, wind, cloud, precipitation, pressure and visibility
- Clean, rounded card UI with gradients and icons
- Simple form to search/select city (built with Riverpod as app state management)

## Prerequisites

- Flutter SDK (stable channel) installed and in PATH
- A connected device or emulator
- Android SDK for Android builds

## Project structure (important files)

- `lib/main.dart` — app entry
- `lib/models/` — data models (weather, location, etc.)
- `lib/services/` — API or network services
- `lib/providers/` — Riverpod providers
- `lib/widgets/` — UI widgets (form, city item cards, grids)
- `assets/images/` — sample weather images

## Notes for developers

- The UI uses `CustomScrollView` with a `SliverAppBar` and a `SliverGrid` for the detail cards. The app bar is implemented to scale down when scrolled.
- Keep images fetched via the API (network) safe by checking and prefixing the URL (e.g. use `https:` when needed).
- The project uses `material_symbols_icons` for compact icons.

## Troubleshooting

- If the app won't start, run `flutter doctor` and resolve any missing dependencies.
- If network images don't appear, inspect the icon URL returned by the API. Some providers return protocol-relative paths (e.g. `//...`) — the code prefixes `https:` when required.

## Contributing

Open a PR with improvements. Keep UI consistent with the rounded-card style and follow existing theme usage.