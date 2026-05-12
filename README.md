# NUD Game

A 2D mobile game built with [Flutter](https://flutter.dev) + [Flame](https://flame-engine.org).

## Tech Stack

| Layer | Choice | Reason |
|---|---|---|
| Language | Dart (Flutter) | Mobile-first, single codebase for iOS & Android |
| Game engine | Flame 1.18 | Mature 2D engine on Flutter; hot-reload, physics, audio |
| CI | GitHub Actions | Free tier, matrix builds for Android + iOS |

Full decision rationale: [docs/adr/001-framework-selection.md](docs/adr/001-framework-selection.md)

## Prerequisites

| Tool | Version |
|---|---|
| Flutter SDK | ≥ 3.22 (stable) |
| Dart | bundled with Flutter |
| Android SDK | API 21+ (for Android builds) |
| Xcode | ≥ 15 (for iOS builds, macOS only) |

Install Flutter: https://docs.flutter.dev/get-started/install

## Local Setup

```bash
# 1. Clone the repo
git clone <repo-url> nud_game
cd nud_game

# 2. Install dependencies
flutter pub get

# 3. Verify setup
flutter doctor
```

## Run Locally

```bash
# Run on a connected device or simulator
flutter run

# Run on a specific device
flutter devices                  # list available devices
flutter run -d <device-id>

# Hot-reload is active while the app is running (press r in terminal)
```

## Build

```bash
# Android debug APK
flutter build apk --debug

# Android release APK (requires signing config)
flutter build apk --release

# iOS debug (no signing, simulator)
flutter build ios --debug --no-codesign

# iOS release (requires Apple Developer account + certificates)
flutter build ios --release
```

## Test

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run a specific test file
flutter test test/nud_game_test.dart
```

## Lint & Format

```bash
flutter analyze        # static analysis
dart format .          # auto-format all Dart files
```

## CI

GitHub Actions runs automatically on every push to `main` and on pull requests:

- **Analyze & Test** — `flutter analyze` + `flutter test`
- **Build Android APK** — debug APK, uploaded as artifact
- **Build iOS** — no-codesign debug build (macOS runner)

See [`.github/workflows/ci.yml`](.github/workflows/ci.yml).

## Project Structure

```
lib/
  main.dart          # entry point
  game/
    nud_game.dart    # FlameGame root, game loop
  scenes/            # game scenes (main menu, gameplay, …)
  components/        # reusable Flame components
  ui/                # Flutter widget overlays
assets/
  images/            # sprites, tilesets
  audio/             # music, SFX
test/                # unit + widget tests
docs/adr/            # architecture decision records
.github/workflows/   # CI pipelines
```
