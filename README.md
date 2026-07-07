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

---

## Group Members

| Name | Registration Number |
|--------|-------------------|
| Aamna Qureshi | FA23-BCS-002 |
| Hira Khurshid | FA23-BCS-038 |
| Maryam Qazi | SP23-BCS-084 |

---

## How to Run

```bash
flutter pub get
flutter run
```

You can run on Chrome:

```bash
flutter run -d chrome
```

or on an Android emulator/device, or any other connected device shown by:

```bash
flutter devices
```

---

## Project Structure

```text
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

---

## Features

- User Login Screen
- User Registration Screen
- Home Feed with Sample Posts
- Upload Post Interface
- User Profile Screen
- Notifications Screen
- Settings Screen
- Bottom Navigation Bar
- Named Route Navigation
- Form Validation
- Reusable Widgets
- Responsive Flutter UI

---

## Navigation Flow

- App launches on **Login Screen**.
- Login → (push) **Register Screen**.
- Login → (replace) **Home Screen (Bottom Navigation Shell)**.
- Bottom Navigation → **Home Feed**, **Upload Post**, **Profile**.
- Home Feed AppBar → **Notifications** and **Settings** screens.
- Settings → **Log Out** → returns to **Login Screen**.

---

## Technologies Used

- Flutter
- Dart
- Material Design
- Navigator Routing
- Stateful & Stateless Widgets

---

## Repository

GitHub Repository:

https://github.com/aamnaqureshi743/InstagramClone_app