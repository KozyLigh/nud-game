# Tech Stack Decision — NUD Game Engine

**Date:** 2026-05-12  
**Author:** CTO (NUD-2)  
**Status:** Accepted

---

## Decision

**Flutter 3.22 + Flame 1.18** is the chosen stack for NUD's 2D mobile game.

---

## Options Considered

| Option | Pros | Cons |
|--------|------|------|
| **Flutter + Flame** ✅ | Mobile-first, hot reload, single codebase (iOS/Android/web), Dart compiles to native ARM, no licensing, active community | Smaller ecosystem than Unity |
| Godot 4 | Mature 2D support, GDScript ergonomics, free | Separate editor + project format, harder CI, GDScript learning curve |
| Unity | Industry standard, huge asset store | Per-seat licensing costs, heavy, splash-screen requirement below revenue threshold |
| Phaser (web) | Fast web prototyping, JS/TS | Web-first; mobile requires WebView wrapper — poor native perf |

---

## Rationale

1. **Mobile-first performance.** Flutter targets iOS and Android with native rendering via Impeller. Flame draws directly on Flutter's canvas at 60 fps+ without a JavaScript bridge.

2. **Single codebase.** One Dart project ships to iOS, Android, and the web. No per-platform divergence on logic or physics.

3. **Fast iteration (hot reload).** Dart's hot reload lets us tweak game feel parameters in under a second — critical for tuning. No equivalent exists in Godot's native export or Unity mobile pipeline.

4. **No licensing costs.** Flutter and Flame are both open-source and free at any revenue level. Unity's runtime fee model adds unpredictable cost at scale.

5. **Flame is production-proven.** Multiple shipped 2D mobile titles (Gravity Eel, Tomb of the Mask clones, puzzle games) demonstrate Flame handles sprite batching, tile maps, physics via `forge2d`, and audio without gaps.

6. **Team velocity.** Dart is close enough to TypeScript/Kotlin that any mobile or web engineer can be productive within days.

---

## Architecture Overview

```
nud_game/
├── lib/
│   ├── main.dart          # Flutter entry point → GameWidget
│   ├── game/
│   │   └── nud_game.dart  # FlameGame root — hosts worlds & scenes
│   └── screens/           # Flutter overlay screens (menus, HUD, shop)
├── assets/
│   ├── images/            # Sprites, tilesets (PNG/WebP)
│   └── audio/             # SFX and music (OGG/MP3)
├── test/                  # Widget + unit tests
└── .github/workflows/     # CI: lint → test → build Android → build iOS
```

---

## Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flame` | `^1.18` | 2D game loop, sprite, component system |
| `flame_audio` | `^2.1` | Pooled audio (SFX/BGM) |
| `flutter_lints` | `^4.0` | Dart lint rules |
| `very_good_analysis` | `^6.0` | Strict analysis baseline |

---

## Risks & Mitigations

| Risk | Mitigation |
|------|------------|
| Flame missing a feature we need | Flame has escape hatches to raw Flutter canvas; we can write custom renderers |
| 3D pivot later | Godot or Unity migration is well-documented; Flame code stays in Dart so logic is portable |
| iOS App Store review | Same process as any Flutter app; no extra review steps |
