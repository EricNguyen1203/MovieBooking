import 'package:cinema_booking_v2/entity/movie.dart';
import 'package:cinema_booking_v2/entity/seat.dart';
import 'package:cinema_booking_v2/entity/ticket.dart';
import 'package:cinema_booking_v2/screen/success.dart';
import 'package:flutter/material.dart';
import 'package:book_my_seat/book_my_seat.dart';

class SeatBookingScreen extends StatefulWidget {
  final Movie movie;
  final Ticket ticket;

  const SeatBookingScreen(
      {super.key, required this.movie, required this.ticket});

  @override
  State<SeatBookingScreen> createState() => _SeatBookingScreenState();
}

class _SeatBookingScreenState extends State<SeatBookingScreen> {
  late Seats seats = Seats(rows: 12, cols: 12);
  late int price = 0;
  late int numOfTicket = 0;
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
                  height: 1 * MediaQuery.of(context).size.height / 5,
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
                      top: MediaQuery.of(context).size.width / 5,
                      right: 1 * MediaQuery.of(context).size.width / 15),
                  width: MediaQuery.of(context).size.width,
                  // height: 4 * MediaQuery.of(context).size.width / 5,
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              widget.ticket.thu +
                                                  ',' +
                                                  widget.ticket.day,
                                            ),
                                            Icon(Icons.arrow_drop_down,
                                                color: Colors.grey),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          border: Border.all(
                                            color: Colors
                                                .grey, // Màu đen cho border
                                            width: 2.0,
                                          ), // Độ rộng của border
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              widget.ticket.time,
                                            ),
                                            Icon(Icons.arrow_drop_down,
                                                color: Colors.grey),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          border: Border.all(
                                            color: Colors
                                                .grey, // Màu đen cho border
                                            width: 2.0,
                                          ), // Độ rộng của border
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 16.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              // height: 100.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.ticket.name_of_cinema,
                                  ),
                                  Icon(Icons.arrow_drop_down,
                                      color: Colors.grey),
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                border: Border.all(
                                  color: Colors.grey, // Màu đen cho border
                                  width: 2.0,
                                ), // Độ rộng của border
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate back to the previous screen
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 40.0),
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'Avaiable',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(width: 20.0),
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'Booked',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(width: 20.0),
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(54, 95, 134, 1),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'Your Selection',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SeatLayoutWidget(
                  onSeatStateChanged: (rowIndex, colIndex, updatedSeatState) {
                    setState(() {
                      seats.seatGrid[rowIndex][colIndex] = updatedSeatState;
                      price = seats.totalPrice();
                      numOfTicket = seats.countSelected();
                    });
                  },
                  stateModel: SeatLayoutStateModel(
                    rows: 12,
                    cols: 12,
                    seatSvgSize: 28,
                    pathUnSelectedSeat:
                        'assets/images/Election_seat_unselected.svg',
                    pathSelectedSeat:
                        'assets/images/Election_seat_selected.svg',
                    pathSoldSeat: 'assets/images/Election_seat_booked.svg',
                    pathDisabledSeat: 'assets/images/Election_seat_booked.svg',
                    currentSeatsState: seats.seatGrid,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90.0),
                  border: Border.all(
                    color: Colors.grey, // Màu đen cho border
                    width: 2.0,
                  ), // Độ rộng của border
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    // width: 30.0,
                    // height: 30.0,
                    // decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    // color: Color.fromRGBO(54, 95, 134, 1),
                    // ),
                    // ),
                    Icon(Icons.airplane_ticket,
                        color: Color.fromRGBO(54, 95, 134, 1)),
                    SizedBox(width: 10.0),
                    Text(
                      'x' + numOfTicket.toString(),
                      style: TextStyle(
                          color: Color.fromRGBO(54, 95, 134, 1), fontSize: 24),
                    ),
                    SizedBox(width: 10.0),
                    Container(
                      height: 30.0,
                      width: 1.0,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      children: [
                        Text(
                          'TOTAL',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        Text('PAYABLE:',
                            style: TextStyle(color: Colors.grey, fontSize: 14))
                      ],
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      '\$' + price.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (numOfTicket == 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Hãy chọn ghế trước khi thanh toán!'),
                ),
              );
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SuccessfullyBookingScreen()));
            }
          },
          child: Icon(Icons.arrow_forward),
        ));
  }
}
