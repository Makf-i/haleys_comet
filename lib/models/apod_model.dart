class APODModel {
  final String title;
  final String url;
  final String mediaType;
  final String explanation;
  final String date;

  APODModel({
    required this.title,
    required this.url,
    required this.mediaType,
    required this.explanation,
    required this.date,
  });

  factory APODModel.fromJson(Map<String, dynamic> json) {
    return APODModel(
      title: json['title'],
      url: json['url'],
      mediaType: json['media_type'],
      explanation: json['explanation'],
      date: json['date'],
    );
  }
}