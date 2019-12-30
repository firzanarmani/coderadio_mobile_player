import 'package:coderadio_mobile_player/models/song.dart';

class RadioInfo extends Song {
  Station station;
  Listeners listeners;
  CurrentSong currentSong;
  NextSong nextSong;
  List<SongHistory> songHistory;

  RadioInfo(
      {this.station,
      this.listeners,
      this.currentSong,
      this.nextSong,
      this.songHistory});

  RadioInfo.fromJson(Map<String, dynamic> json) {
    station =
        json['station'] != null ? new Station.fromJson(json['station']) : null;
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
        'station': this.station,
        'listeners': this.listeners,
        'now_playing': this.currentSong,
        'playing_next': this.nextSong,
        'song_history': this.songHistory,
      };
}

class Station {
  int id;
  String listenUrl;
  List<AudioStream> mounts = new List<AudioStream>();
  List<AudioStream> relays = new List<AudioStream>();

  Station({this.id, this.listenUrl, this.mounts, this.relays});

  Station.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    listenUrl = json['listen_url'];
    mounts = json['mounts'].forEach((mount) {
      mounts.add(new AudioStream.fromJson(mount));
    });
    relays = json['remotes'].forEach((relay) {
      relays.add(new AudioStream.fromJson(relay));
    });
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'listen_url': this.listenUrl,
        'mounts': this.mounts,
        'remotes': this.relays,
      };
}

class AudioStream {
  int id;
  String name;
  String url;
  int bitrate;
  Listeners listeners;

  AudioStream({this.id, this.name, this.url, this.bitrate, this.listeners});

  AudioStream.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    bitrate = json['bitrate'];
    listeners = new Listeners.fromJson(json['listeners']);
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'name': this.name,
        'url': this.url,
        'bitrate': this.bitrate,
        'listeners': this.listeners,
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
