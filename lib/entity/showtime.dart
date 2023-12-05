
class ShowTime{
  String time;
  bool status;

  ShowTime({
    required this.time,
    required this.status,
  });

  factory ShowTime.fromMap(Map<String, dynamic> map) {
    return ShowTime(
      time: map['time'] ?? '',
      status: map['status'] ?? false,
    );
  }
}