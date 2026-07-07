# InstaClone — Phase 1 & Phase 2

A Flutter UI clone of Instagram covering:

- **Phase 1 — Frontend UI**: Login, Registration, Home Feed, Upload Post,
  Profile, Notifications, and Settings screens, built with reusable widgets
  (PostCard), Forms with validation, ListView/GridView, Cards, Dialogs,
  SnackBars, and responsive layout adjustments.
- **Phase 2 — Navigation & App Flow**: Named routes, `Navigator.push` /
  `pop` / `pushReplacement`, data flow between screens, and a
  `BottomNavigationBar` connecting Home, Upload, and Profile tabs.

All data shown (posts, notifications, profile stats) is hardcoded sample
data — there is no backend yet. That's intentionally out of scope for this
phase.

## How to run

```bash
flutter pub get
flutter run
```

You can run on Chrome (`flutter run -d chrome`), an Android
emulator/device, or any other connected device shown by `flutter devices`.

## Project structure

```
lib/
  main.dart                  # MaterialApp + named route table
  models/
    post.dart                # Post data model + hardcoded sample posts
  routes/
    app_routes.dart          # Centralized route name constants
  screens/
    login_screen.dart
    register_screen.dart
    main_nav_screen.dart     # Bottom nav shell (Home / Upload / Profile)
    home_feed_screen.dart
    upload_post_screen.dart
    profile_screen.dart
    notifications_screen.dart
    settings_screen.dart
  widgets/
    post_card.dart           # Reusable feed post card
```

## Navigation flow

- App launches on **Login**.
- Login → (push) **Register**, or (replace) → **Home** (bottom nav shell).
- Home tab bar → **Home Feed** / **Upload Post** / **Profile**.
- Home Feed app bar → (push) **Notifications**, (push) **Settings**.
- Settings → Log Out → pops back to **Login**.
