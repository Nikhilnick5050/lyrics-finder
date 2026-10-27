# Lyrics Finder - Flutter App

A simple Flutter app to search for song lyrics using the Genius API.

## Features

- Search for songs by name
- View full lyrics
- Share lyrics with others
- Clean, modern UI with Material 3 design

## Prerequisites

- Flutter SDK (3.0 or higher)
- Android Studio / VS Code
- A Genius API key (free)

## Setup

1. Get a Genius API key:
   - Go to https://genius.com/api-clients
   - Sign up and create a new API client
   - Copy your API key

2. Update the API key in the app:
   - Open `lib/services/lyrics_service.dart`
   - Find the line: `static const String apiKey = 'YOUR_GENIUS_API_KEY_HERE';`
   - Replace `'YOUR_GENIUS_API_KEY_HERE'` with your actual API key

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   └── lyrics_model.dart        # Lyrics data model
├── services/
│   └── lyrics_service.dart      # API service for fetching lyrics
└── screens/
    └── home_screen.dart         # Main screen with search and lyrics display
```

## How It Works

1. User enters a song name
2. App searches Genius API for the song
3. App fetches the song page and extracts lyrics
4. Lyrics are displayed in a clean card
5. User can share the lyrics

## Notes

- This app uses the free Genius API (rate limits apply)
- Some songs may not have complete lyrics
- Internet connection is required
