import 'dart:ffi';

import 'package:cinema_booking_v2/common_widget/common_widget.dart';
import 'package:cinema_booking_v2/entity/cinema.dart';
import 'package:cinema_booking_v2/entity/day.dart';
import 'package:cinema_booking_v2/entity/movie.dart';
import 'package:cinema_booking_v2/entity/showtime.dart';
import 'package:cinema_booking_v2/entity/ticket.dart';
import 'package:cinema_booking_v2/screen/home_screen.dart';
import 'package:cinema_booking_v2/screen/seat_booking.dart';
import 'package:flutter/material.dart';

class MoviePageScreen extends StatefulWidget {
  final Movie movie;

  MoviePageScreen({super.key, required this.movie});

  @override
  State<MoviePageScreen> createState() => _MoviePageScreenState();
}

class _MoviePageScreenState extends State<MoviePageScreen> {
  List<Color> containerColors = List.generate(7, (index) => Colors.grey);
  List<Color> textColors = List.generate(7, (index) => Colors.grey);
  late Day currentDay;
  late bool newDay;
  late Ticket ticket;

  @override
  void initState() {
    containerColors[0] = Colors.blue;
    textColors[0] = Colors.black;
    currentDay = widget.movie.days[0];
    ticket = Ticket(
        thu: currentDay.thu, time: '', day: currentDay.day, name_of_cinema: '');
    newDay = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                // Phần background, phần trên chiếm 1/3 là hình ảnh
                Container(
                  height: 2 * MediaQuery.of(context).size.height / 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.movie.imageUrl,
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), // Thay đổi độ tối ở đây
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
                // Phần background, phần dưới chiếm 2/3 là nền trắng
                // Container(
                // margin: EdgeInsets.only(top: 2 * MediaQuery.of(context).size.height / 5),
                // height: 1 * MediaQuery.of(context).size.height / 5,
                // color: Colors.white,
                // ),
                // Nội dung trên background
                Container(
                  margin: EdgeInsets.only(
                      left: 1 * MediaQuery.of(context).size.width / 15,
                      top: MediaQuery.of(context).size.width / 4,
                      right: 1 * MediaQuery.of(context).size.width / 15),
                  width: MediaQuery.of(context).size.width,
                  height: 4 * MediaQuery.of(context).size.width / 5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                            0.1), // Màu và độ trong suốt của đổ bóng
                        spreadRadius: 20, // Độ lan rộng của đổ bóng
                        blurRadius: 20, // Độ mờ của đổ bóng
                        offset: Offset(0, 3), // Độ lệch của đổ bóng
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  widget.movie.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 28.0,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.star, color: Colors.grey),
                                    SizedBox(width: 8.0),
                                    Text(widget.movie.rate),
                                    SizedBox(width: 8.0),
                                    Icon(Icons.watch, color: Colors.grey),
                                    SizedBox(width: 8.0),
                                    Text(
                                      widget.movie.time,
                                    ),
                                    SizedBox(width: 8.0),
                                    Icon(Icons.calendar_month,
                                        color: Colors.grey),
                                    SizedBox(width: 8.0),
                                    Text(
                                      widget.movie.year,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'Sysnopis',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                    // Spacer to push the next items to the right
                                    Spacer(),

                                    // First Container with gray background and dark gray text
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50.0))),
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        widget.movie.category[0],
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                    SizedBox(width: 8.0),

                                    // Second Container with gray background and dark gray text
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50.0))),
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        widget.movie.category[1],
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(width: 8.0),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: SingleChildScrollView(
                                      child: Text(
                                        widget.movie.description,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate back to the previous screen
                    Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage()),
              );
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 40.0),
                    padding: EdgeInsets.all(10.0),
                    child: Icon(Icons.arrow_back, color: Colors.white,),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                  // width: MediaQuery.of(context).size.width,
                  height: 80.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.movie.days.length,
                    itemBuilder: (context, index) {
                      Day day = widget.movie.days[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            // Khi Container được nhấn vào, cập nhật màu sắc của border
                            setState(() {
                              newDay = true;
                              ticket.day = day.day;
                              ticket.thu = day.thu;
                              currentDay = day;
                              print(day.day);
                              containerColors =
                                  List.generate(7, (index) => Colors.grey);
                              textColors =
                                  List.generate(7, (index) => Colors.grey);
                              containerColors[index] = Colors.blue;
                              textColors[index] =
                                  Colors.black; // Đổi màu sắc thành màu xanh
                            });
                          },
                          child: Container(
                            width: 65.0,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(
                                color: containerColors[
                                    index], // Màu đen cho border
                                width: 2.0, // Độ rộng của border
                              ),
                            ),
                            child: Column(children: [
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                day.thu,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: textColors[index],
                                ),
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                day.day,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: textColors[index],
                                ),
                              ),
                            ]),
                          ),
                        ),
                      );
                    },
                  )),
            ),
            Expanded(
                child: CinemaListWidget(
              day: currentDay,
              ticket: ticket,
              newDay: newDay,
            ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (ticket.isValid()) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SeatBookingScreen(
                          movie: widget.movie,
                          ticket: ticket,
                        )),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Hãy cập nhật đủ thông tin'),
                ),
              );
            }
          },
          child: Icon(Icons.arrow_forward),
        ));
  }
}

class ContentWidget extends StatelessWidget {
  late final Movie movie;

  ContentWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    // Thay thế bằng nội dung bạn muốn hiển thị trong Container trên
    return Center(
      child: Text(
        movie.description,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    );
  }
}

class CinemaListWidget extends StatefulWidget {
  final Day day;
  late bool newDay;
  final Ticket ticket;

  CinemaListWidget(
      {required this.day, required this.ticket, required this.newDay});

  @override
  _CinemaListWidgetState createState() => _CinemaListWidgetState();
}

class _CinemaListWidgetState extends State<CinemaListWidget> {
  late List<List<Color>> containerColors = List.generate(
    100,
    (index) => List<Color>.filled(100, Colors.grey),
  );
  late List<List<Color>> textColors = List.generate(
    100,
    (index) => List<Color>.filled(100, Colors.grey),
  );
  @override
  Widget build(BuildContext context) {
    if (widget.newDay == true) {
      containerColors = List.generate(
        100,
        (index) => List<Color>.filled(100, Colors.grey),
      );

      textColors = List.generate(
        100,
        (index) => List<Color>.filled(100, Colors.grey),
      );
      widget.ticket.name_of_cinema = '';
      widget.ticket.time = '';
    }
    if (!widget.day.cinemas.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: widget.day.cinemas.length,
          itemBuilder: (BuildContext context, int index1) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    widget.day.cinemas[index1].name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ), // Thành phần trên cùng là Text
                // Thành phần dưới cùng là ListView theo chiều ngang
                Container(
                  height: 55.0, // Điều chỉnh chiều cao của Container
                  child: ListView.builder(
                    scrollDirection:
                        Axis.horizontal, // Đặt hướng cuộn là chiều ngang
                    itemCount: widget.day.cinemas[index1].showtimes.length,
                    itemBuilder: (BuildContext context, int index2) {
                      // containerColors = List.generate(
                      //     widget.day.cinemas[index1].showtimes.length,
                      //     (index) => Colors.grey);
                      // textColors = List.generate(
                      //     widget.day.cinemas[index1].showtimes.length,
                      //     (index) => Colors.grey);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (widget
                                .day.cinemas[index1].showtimes[index2].status) {
                              widget.ticket.name_of_cinema =
                                  widget.day.cinemas[index1].name;
                              widget.ticket.time = widget
                                  .day.cinemas[index1].showtimes[index2].time;
                              widget.newDay = false;
                              containerColors = List.generate(
                                100,
                                (index) => List<Color>.filled(100, Colors.grey),
                              );
                              ;
                              textColors = List.generate(
                                100,
                                (index) => List<Color>.filled(100, Colors.grey),
                              );
                              ;
                              containerColors[index1][index2] = Colors.blue;
                              textColors[index1][index2] = Colors.black;
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: widget.day.cinemas[index1].showtimes[index2]
                                    .status
                                ? Colors.white
                                : Colors.grey[800],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(
                              color: containerColors[index1]
                                  [index2], // Màu đen cho border
                              width: 2.0, // Độ rộng của border
                            ),
                          ),
                          child: Text(
                            widget.day.cinemas[index1].showtimes[index2].time,
                            style: TextStyle(
                              color: textColors[index1][index2],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Text(
                'Out of showtime in the moment!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              )),
        ),
      );
    }
  }
}
