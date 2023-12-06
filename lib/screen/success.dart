
import 'package:flutter/material.dart';

class SuccessfullyBookingScreen extends StatefulWidget {
  const SuccessfullyBookingScreen({super.key});

  @override
  State<SuccessfullyBookingScreen> createState() => _SuccessfullyBookingScreenState();
}

class _SuccessfullyBookingScreenState extends State<SuccessfullyBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: Text('Booking Successfully!!'),
  ),
  body: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Text('You have successfully booked your tickets, have fun watching the movie!!',)),
    ),
  ),
  );
  }
}