import 'package:coderadio_mobile_player/models/song.dart';

class RadioInfo extends Song {
  Listeners listeners;
  CurrentSong currentSong;
  NextSong nextSong;
  List<SongHistory> songHistory;

  RadioInfo(
      {this.listeners, this.currentSong, this.nextSong, this.songHistory});

  RadioInfo.fromJson(Map<String, dynamic> json) {
    listeners = json['listeners'] != null
        ? new Listeners.fromJson(json['listeners'])
        : null;
    currentSong = json['now_playing'] != null
        ? new CurrentSong.fromJson(json['now_playing'])
        : null;
    nextSong = json['playing_next'] != null
        ? new NextSong.fromJson(json['playing_next'])
        : null;
    if (json['song_history'] != null) {
      songHistory = new List<SongHistory>();
      json['song_history'].forEach((s) {
        songHistory.add(new SongHistory.fromJson(s));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        'listeners': this.listeners,
        'now_playing': this.currentSong,
        'playing_next': this.nextSong,
        'song_history': this.songHistory,
      };
}

class Listeners {
  int current;
  int unique;
  int total;

  Listeners({this.current, this.unique, this.total});

  Listeners.fromJson(Map<String, dynamic> json) {
    current = json['current'];
    unique = json['unique'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() => {
        'current': this.current,
        'unique': this.unique,
        'total': this.total,
      };
}

class CurrentSong {
  int elapsed;
  int remaining;
  int playedAt;
  int duration;
  Song song;

  CurrentSong(
      {this.elapsed, this.remaining, this.playedAt, this.duration, this.song});

  CurrentSong.fromJson(Map<String, dynamic> json) {
    elapsed = json['elapsed'];
    remaining = json['remaining'];
    playedAt = json['played_at'];
    duration = json['duration'];
    song = json['song'] != null ? new Song.fromJson(json['song']) : null;
  }

  Map<String, dynamic> toJson() => {
        'elapsed': this.elapsed,
        'remaining': this.remaining,
        'played_at': this.playedAt,
        'duration': this.duration,
        'song': this.song,
      };
}

class NextSong {
  Song song;

  NextSong({this.song});

  NextSong.fromJson(Map<String, dynamic> json) {
    song = json['song'] != null ? new Song.fromJson(json['song']) : null;
  }

  Map<String, dynamic> toJson() => {
        'song': this.song,
      };
}

class SongHistory {
  Song song;

  SongHistory({this.song});

  SongHistory.fromJson(Map<String, dynamic> json) {
    song = json['song'] != null ? new Song.fromJson(json['song']) : null;
  }

  Map<String, dynamic> toJson() => {
        'song': this.song,
      };
}
