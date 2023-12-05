
class Ticket{
  String thu;
  String day;
  String name_of_cinema;
  String time;

  Ticket({
    required this.thu,
    required this.day,
    required this.name_of_cinema,
    required this.time,
  });
  bool isValid() {
    return thu.isNotEmpty &&
        day.isNotEmpty &&
        name_of_cinema.isNotEmpty &&
        time.isNotEmpty;
  }


}