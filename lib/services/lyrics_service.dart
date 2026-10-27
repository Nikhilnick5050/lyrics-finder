import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/lyrics_model.dart';

class LyricsService extends GetxService {
  static const String apiKey = 'YOUR_GENIUS_API_KEY_HERE';

  /// Search for a song and fetch lyrics
  Future<LyricsModel?> fetchLyrics(String songName) async {
    try {
      // 1. Search for the song
      final searchUrl = Uri.parse(
        'https://api.genius.com/search?q=${Uri.encodeComponent(songName)}',
      );

      final searchResponse = await http.get(
        searchUrl,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'User-Agent': 'LyricsFinder/1.0',
        },
      );

      if (searchResponse.statusCode != 200) {
        debugPrint('Search failed: ${searchResponse.statusCode}');
        return null;
      }

      final searchData = json.decode(searchResponse.body);
      final hits = searchData['response']['hits'];

      if (hits.isEmpty) {
        debugPrint('No songs found for: $songName');
        return null;
      }

      // 2. Get the first result
      final songUrl = hits[0]['result']['url'];
      final songTitle = hits[0]['result']['title'];
      final artistName = hits[0]['result']['primary_artist']['name'];

      // 3. Fetch lyrics from the song page
      final lyricsResponse = await http.get(
        Uri.parse(songUrl),
        headers: {
          'User-Agent': 'LyricsFinder/1.0',
        },
      );

      if (lyricsResponse.statusCode != 200) {
        debugPrint('Failed to fetch lyrics: ${lyricsResponse.statusCode}');
        return null;
      }

      // 4. Extract lyrics from HTML
      String lyrics = _extractLyrics(lyricsResponse.body);

      if (lyrics.isEmpty) {
        debugPrint('No lyrics found');
        return null;
      }

      return LyricsModel(
        title: songTitle,
        artist: artistName,
        lyrics: lyrics,
      );
    } catch (e) {
      debugPrint('Error fetching lyrics: $e');
      return null;
    }
  }

  /// Extract lyrics from Genius HTML response
  String _extractLyrics(String html) {
    // Genius wraps lyrics in a specific div
    final pattern = RegExp(r'<div class="lyrics">(.*?)</div>', dotAll: true);
    final match = pattern.firstMatch(html);

    if (match != null) {
      String lyrics = match.group(1)!;
      // Clean up HTML tags and entities
      lyrics = lyrics
          .replaceAll(RegExp(r'<[^>]+>'), '') // Remove all HTML tags
          .replaceAll('&amp;', '&')
          .replaceAll('&lt;', '<')
          .replaceAll('&gt;', '>')
          .replaceAll('&quot;', '"')
          .replaceAll('&apos;', "'")
          .replaceAll('&nbsp;', ' ')
          .trim();
      return lyrics;
    }

    return '';
  }
}
