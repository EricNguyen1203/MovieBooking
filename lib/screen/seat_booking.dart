import 'package:cinema_booking_v2/entity/movie.dart';
import 'package:cinema_booking_v2/screen/success.dart';
import 'package:flutter/material.dart';

class SeatBookingScreen extends StatefulWidget {
  final Movie movie;

  const SeatBookingScreen({super.key, required this.movie});

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
  body: Stack(
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
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 1 * MediaQuery.of(context).size.width / 10, top: MediaQuery.of(context).size.width / 2, right: 1 * MediaQuery.of(context).size.width / 10),
            width: 4 * MediaQuery.of(context).size.width / 5,
            height: 3* MediaQuery.of(context).size.width / 5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0),),
              boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Màu và độ trong suốt của đổ bóng
                spreadRadius: 20, // Độ lan rộng của đổ bóng
                blurRadius: 20, // Độ mờ của đổ bóng
                offset: Offset(0, 3), // Độ lệch của đổ bóng
              ),
            ],

            ),
            child: Center(
              child: Text(
                widget.movie.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SuccessfullyBookingScreen())
      );
    },
    child: Icon(Icons.arrow_forward),
));
  }
}