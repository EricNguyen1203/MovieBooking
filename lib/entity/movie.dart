import 'package:cinema_booking_v2/entity/day.dart';

class Movie {
  String imageUrl;
  String name;
  String time;
  List<String> category;
  String description;
  String rate;
  String year;
  List<Day> days;

  Movie({
    required this.imageUrl,
    required this.name,
    required this.time,
    required this.category,
    required this.description,
    required this.rate,
    required this.year,
    required this.days,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    List<dynamic> daysData = map['listday'] ?? [];
    List<Day> days = daysData.map((day) => Day.fromMap(day)).toList();

    return Movie(
      imageUrl: map['ImageUrl'] ?? '',
      name: map['name'] ?? '',
      time: map['time'] ?? '',
      category: [map['category1'] ?? '', map['category2'] ?? ''],
      description: map['description'] ?? '',
      rate: map['rate'] ?? '',
      year: map['year'] ?? '',
      days: days,
    );
  }
}
