import 'package:cinema_booking_v2/common_widget/common_widget.dart';
import 'package:cinema_booking_v2/entity/movie.dart';
import 'package:cinema_booking_v2/screen/seat_booking.dart';
import 'package:flutter/material.dart';

class MoviePageScreen extends StatefulWidget {
  final Movie movie;

  MoviePageScreen({super.key, required this.movie});

  @override
  State<MoviePageScreen> createState() => _MoviePageScreenState();
}

class _MoviePageScreenState extends State<MoviePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(title: 'Browse'),
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
                    color: Colors.black
                        .withOpacity(0.1), // Màu và độ trong suốt của đổ bóng
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
                                Icon(Icons.calendar_month, color: Colors.grey),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SeatBookingScreen(movie: widget.movie)),
            );
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
