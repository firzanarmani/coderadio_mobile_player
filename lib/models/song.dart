class Song {
  String id;
  String text;
  String artist;
  String title;
  String album;
  String art;

  Song({
    this.id,
    this.text,
    this.artist,
    this.title,
    this.album,
    this.art,
  });

  Song.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    artist = json['artist'];
    title = json['title'];
    album = json['album'];
    art = json['art'];
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'text': this.text,
        'artist': this.artist,
        'title': this.title,
        'album': this.album,
        'art': this.art,
      };
}
