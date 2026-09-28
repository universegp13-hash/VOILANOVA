# VOILANOVA

Premium multi-vendor marketplace app built with Flutter, Riverpod, and Supabase.

## Setup

1. Install Flutter: https://flutter.dev/docs/get-started/install
2. Open this project in VS Code or your preferred editor.
3. Run:
   ```bash
   flutter pub get
   flutter run
   ```

## Project Structure

- `lib/main.dart`: app bootstrap
- `lib/src/app.dart`: app shell, routing, theme
- `lib/src/features`: UI screens for customer, seller, and admin workflows
- `lib/src/models`: domain models for products, orders, payouts, and profiles
- `lib/src/providers`: Riverpod state providers
- `lib/src/services`: Supabase and payment integration
- `database/schema.sql`: PostgreSQL schema for Supabase

## Supabase SQL

Execute `database/schema.sql` in Supabase SQL editor to provision the marketplace schema.

## Running

- Mobile/emulator: `flutter run`
- Web: `flutter run -d chrome`
- If you want to generate platform directories, run `flutter create .` before `flutter pub get`.
