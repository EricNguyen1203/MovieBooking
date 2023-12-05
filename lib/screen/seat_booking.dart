import 'package:cinema_booking_v2/entity/movie.dart';
import 'package:cinema_booking_v2/entity/ticket.dart';
import 'package:cinema_booking_v2/screen/success.dart';
import 'package:flutter/material.dart';

class SeatBookingScreen extends StatefulWidget {
  final Movie movie;
  final Ticket ticket;

  const SeatBookingScreen(
      {super.key, required this.movie, required this.ticket});

  @override
  State<SeatBookingScreen> createState() => _SeatBookingScreenState();
}

class _SeatBookingScreenState extends State<SeatBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SeatBooking'),
        ),
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
                                    Container(
                                      child: Text(
                                        widget.ticket.thu +
                                            ',' +
                                            widget.ticket.day,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        border: Border.all(
                                          color: Colors
                                              .black, // Màu đen cho border
                                          width: 2.0,
                                        ), // Độ rộng của border
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Container(
                                      child: Text(
                                        widget.ticket.time,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        border: Border.all(
                                          color: Colors
                                              .black, // Màu đen cho border
                                          width: 2.0,
                                        ), // Độ rộng của border
                                      ),
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
                                    child: Text(
                                      widget.movie.description,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 16.0),
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
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SuccessfullyBookingScreen()));
          },
          child: Icon(Icons.arrow_forward),
        ));
  }
}
