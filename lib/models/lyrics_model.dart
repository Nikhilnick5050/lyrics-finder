import 'package:json_annotation/json_annotation.dart';

part 'lyrics_model.g.dart';

@JsonSerializable()
class LyricsModel {
  final String? title;
  final String? artist;
  final String? lyrics;

  LyricsModel({
    this.title,
    this.artist,
    this.lyrics,
  });

  factory LyricsModel.fromJson(Map<String, dynamic> json) =>
      _$LyricsModelFromJson(json);

  Map<String, dynamic> toJson() => _$LyricsModelToJson(this);
}
