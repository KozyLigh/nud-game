# ADR-001: 2D Game Framework Selection

**Date:** 2026-05-12  
**Status:** Accepted  
**Deciders:** CTO

---

## Context

NUD is a mobile-first 2D game company. We need a framework that:
- Targets iOS and Android from a single codebase
- Delivers smooth frame rates (60 fps) on mid-range devices
- Provides fast iteration / hot-reload for game-feel tuning
- Has a strong ecosystem and long-term support guarantees
- Minimises battery and memory overhead

### Options Evaluated

| Framework | Language | Mobile perf | Iteration speed | Maturity | Notes |
|-----------|----------|------------|-----------------|----------|-------|
| **Flutter + Flame** | Dart | ★★★★★ | ★★★★★ | ★★★★ | AOT, Skia/Impeller, native widgets possible |
| Godot 4 | GDScript / C# | ★★★★ | ★★★★ | ★★★★ | Excellent editor; mobile export can lag behind desktop |
| Unity | C# | ★★★★ | ★★★ | ★★★★★ | Heavy toolchain; licensing changes add risk |
| Phaser | JavaScript | ★★★ | ★★★★ | ★★★★ | WebGL-first; Capacitor wrapping adds overhead |

---

## Decision

**Flutter + Flame**

### Rationale

1. **Mobile-first performance.** Flutter compiles Dart to native ARM via AOT. The Impeller renderer eliminates shader compilation jank — a common cause of frame drops on first play. Benchmarks show 60 fps on mid-range Android with complex sprite counts well above what we expect in v1.

2. **Single codebase, true native.** One Dart project produces an optimised iOS IPA and Android APK. No JS bridge, no WebView.

3. **Fast iteration.** Flutter's hot-reload refreshes the running game in < 1 s. Combined with Flame's component system this is the fastest game-feel tuning loop of the evaluated options.

4. **Flame is purpose-built for 2D.** Flame 1.18 ships with a component-entity system, collision detection, tiled map support, camera, effects, and a sprite animation API — covering the full feature set of a mobile 2D game without needing additional plugins.

5. **Ecosystem health.** Flutter is Google-backed with a massive pub.dev ecosystem. Flame is actively maintained with regular releases tracking Flutter stable.

6. **No licensing risk.** Both Flutter and Flame are BSD/MIT open-source. No revenue-split or seat-based fee (contrast with Unity's runtime fee controversy).

### Trade-offs Accepted

- **No visual editor.** Unlike Godot or Unity, Flame has no drag-and-drop scene editor. Scenes are coded in Dart. This is acceptable for a small founding team writing code directly.
- **Dart.** Dart is less common than C# or JavaScript. Onboarding engineers requires learning Dart — but it is approachable for anyone with Java/Kotlin/TypeScript experience.

---

## Consequences

- All game code is Dart/Flutter. Engineers hired must know or be willing to learn Dart.
- CI builds an Android APK on every PR; iOS builds run on macOS runners when needed.
- Godot and Unity remain on the table for a potential future 3D expansion, but will not be introduced for the current 2D game slate.
