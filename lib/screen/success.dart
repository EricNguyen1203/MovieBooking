
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
  body: Center(
    child: Text('You have successfully booked your tickets, have fun watching the movie!!'),
  ),
  );
  }
}