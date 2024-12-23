import 'dart:convert';

class ApodModel {
  final String? date;
  final String? explanation;
  final String? hdurl;
  final String? mediaType;
  final String? serviceVersion;
  final String? title;
  final String? url;
  final String? thumb;
  bool isFavorite;

  ApodModel(
      {required this.date,
      required this.explanation,
      required this.hdurl,
      required this.mediaType,
      required this.serviceVersion,
      required this.title,
      required this.url,
      required this.thumb,
      this.isFavorite = false});

  factory ApodModel.fromJson(Map<String, dynamic> json) {
    return ApodModel(
        date: json['date'],
        explanation: json['explanation'],
        hdurl: json['hdurl'],
        mediaType: json['media_type'],
        serviceVersion: json['service_version'],
        title: json['title'],
        url: json['url'],
        thumb: json['thumbnail_url']);
  }

  ApodModel copyWith({
    String? date,
    String? explanation,
    String? hdurl,
    String? mediaType,
    String? serviceVersion,
    String? title,
    String? url,
    String? thumb,
    bool? isFavorite,
  }) {
    return ApodModel(
        date: date ?? this.date,
        explanation: explanation ?? this.explanation,
        hdurl: hdurl ?? this.hdurl,
        mediaType: mediaType ?? this.mediaType,
        serviceVersion: serviceVersion ?? this.serviceVersion,
        title: title ?? this.title,
        url: url ?? this.url,
        thumb: thumb ?? this.thumb,
        isFavorite: isFavorite ?? false);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'explanation': explanation,
      'hdurl': hdurl,
      'media_type': mediaType,
      'service_version': serviceVersion,
      'title': title,
      'url': url,
      'thumbnail_url': thumb,
    };
  }

  factory ApodModel.fromMap(Map<String, dynamic> map) {
    return ApodModel(
      date: map['date'] != null ? map['date'] as String : null,
      explanation:
          map['explanation'] != null ? map['explanation'] as String : null,
      hdurl: map['hdurl'] != null ? map['hdurl'] as String : null,
      mediaType: map['mediaType'] != null ? map['mediaType'] as String : null,
      serviceVersion: map['serviceVersion'] != null
          ? map['serviceVersion'] as String
          : null,
      title: map['title'] != null ? map['title'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
      thumb: map['thumb'] != null ? map['thumb'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());
}
