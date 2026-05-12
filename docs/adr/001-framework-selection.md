# ADR 001 — 2D Game Framework Selection

**Date:** 2026-05-12  
**Status:** Accepted  
**Deciders:** CTO

---

## Context

NUD is a 2D mobile game company targeting iOS and Android. We evaluated four candidate frameworks:

| Framework | Language | Mobile-native | 2D maturity | License | Cost |
|---|---|---|---|---|---|
| Flutter + Flame | Dart | Yes (primary target) | High | BSD/MIT | Free |
| Godot 4 | GDScript/C# | Yes (export) | Very High | MIT | Free |
| Unity | C# | Yes | Very High | Proprietary | Freemium |
| Phaser | JavaScript | No (web-first) | High | MIT | Free |

---

## Decision

**Flutter + Flame**

---

## Rationale

### Why Flutter/Flame

1. **Mobile-first rendering.** Flutter compiles to native ARM and renders via Impeller (Metal on iOS, Vulkan on Android) — no JS bridge, no WebView. Consistent 60/120 fps on target devices.

2. **Single codebase, true cross-platform.** One Dart codebase produces store-ready iOS and Android binaries. Flame sits on top of Flutter's widget tree, so native UI overlays (menus, HUD, IAP) require no bridging.

3. **Hot reload.** Flutter's hot-reload cuts the game-feel iteration loop to seconds. Critical for tuning physics, timing, and juice.

4. **Flame 1.x maturity.** Flame ships a complete 2D toolkit: component/entity system, collision detection, tiled map support, camera, particle system, audio via `flame_audio`. It is actively maintained and has a growing community.

5. **Battery and memory.** Flutter's rendering pipeline is designed for 60fps on mid-range phones. Flame avoids a full physics engine by default (keeping overhead low for simple 2D games) while providing Forge2D as an opt-in.

6. **No licensing risk.** Both Flutter and Flame are fully open-source (BSD/MIT). Unity's 2023 Runtime Fee incident is a cautionary tale; we own no legal exposure here.

### Why Not Godot

Godot is excellent for 2D and was the main alternative. Rejected because:
- Smaller mobile-deployment ecosystem (Flutter has more battle-tested Play Store / App Store tooling).
- Less familiar to Flutter/Dart engineers who are common mobile hires.
- Godot export pipeline adds a build step; Flutter's is native.

### Why Not Unity

- Proprietary license and historical fee changes introduce commercial risk.
- Heavier runtime (C# IL2CPP) increases binary size and startup time for a 2D game that doesn't need a 3D engine.
- Overkill for a 2D-only roadmap.

### Why Not Phaser

- Web-only; native mobile requires Capacitor/Cordova wrapper, adding latency and reducing access to native APIs (haptics, push notifications, IAP).
- JS runtime performance ceiling is lower than native Flutter for game loops.

---

## Consequences

- Engineers need Dart/Flutter familiarity. Ramp-up is fast for anyone with mobile or typed-language background.
- CI must provision Flutter SDK — handled in `.github/workflows/ci.yml` via `subosito/flutter-action`.
- Game assets live in `assets/` and are declared in `pubspec.yaml`.
- Physics: use Flame's built-in AABB collision system first; add Forge2D only when a simulation-heavy mechanic requires it.
- Audio: `flame_audio` (wraps `audioplayers`) covers SFX + music looping.

---

## Review

This decision should be revisited if:
- We pivot to 3D content (→ consider Unity or Godot 4).
- We need web distribution as a first-class target (→ consider Phaser or a Flutter web build).
- Flame stalls or loses maintainer support (→ consider migrating game logic to Godot).
