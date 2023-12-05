import 'package:cinema_booking_v2/entity/cinema.dart';

class Day{
  String day;
  String thu;
  List<Cinema> cinemas;
  
  Day({
    required this.day,
    required this.cinemas,
    required this.thu,
  });

  factory Day.fromMap(Map<String, dynamic> map) {
    List<dynamic> cinemasData = map['cinemas'] ?? [];
    List<Cinema> cinemas = cinemasData.map((cinema) => Cinema.fromMap(cinema)).toList();

    return Day(
      day: map['day'] ?? '',
      thu: map['thu'] ?? '',
      cinemas: cinemas,
    );
  }
}