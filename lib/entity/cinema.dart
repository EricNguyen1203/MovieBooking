
import 'package:cinema_booking_v2/entity/showtime.dart';

class Cinema{
  String name;
  List<ShowTime> showtimes;

  Cinema({
    required this.name,
    required this.showtimes,
  });

  factory Cinema.fromMap(Map<String, dynamic> map) {
    List<dynamic> showtimesData = map['showtimes'] ?? [];
    List<ShowTime> showtimes = showtimesData.map((showtime) => ShowTime.fromMap(showtime)).toList();

    return Cinema(
      name: map['name'] ?? '',
      showtimes: showtimes,
    );
  }
}