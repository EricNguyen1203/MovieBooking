// Dùng để cập nhật dữ liệu lên Firestore Firebase

import 'package:cinema_booking_v2/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('poster_items');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Thêm dữ liệu vào Firestore
            addUser();
          },
          child: Text('Thêm dữ liệu'),
        ),
      ),
    );
  }

  Future<void> addUser() {
    // Thêm dữ liệu vào collection "users"
    return users
        .add({
          'ImageUrl':
              'https://firebasestorage.googleapis.com/v0/b/cinemabookingv4.appspot.com/o/ixLH2iM9at8BbuLr5wQWnCfwhJO.jpg?alt=media&token=62bdb25c-ee09-4b37-8b85-ae3bb058ce26',
          'category1': 'Chính kịch',
          'category2': 'Lịch sử',
          'description': "Với nhân vật trung tâm là J. Robert Oppenheimer, nhà vật lý lý thuyết người đứng đầu phòng thí nghiệm Los Alamos, thời kỳ Thế chiến II. Ông đóng vai trò quan trọng trong Dự án Manhattan, tiên phong trong nhiệm vụ phát triển vũ khí hạt nhân, và được coi là một trong những “cha đẻ của bom nguyên tử”.",
          'listday': [
            {
              'cinemas': [
                {
                  'name': 'BHD',
                  'showtimes': [
                    {'status': true, 'time': '09:30 AM'},
                    {'status': false, 'time': '10:30 AM'},
                    {'status': false, 'time': '5:30 PM'},
                    {'status': true, 'time': '8:30 PM'},
                  ],
                },
                {
                  'name': 'CGV Sinh viên',
                  'showtimes': [
                    {'status': true, 'time': '4:00 PM'},
                  ],
                },
                {
                  'name': 'CGV',
                  'showtimes': [
                    {'status': true, 'time': '7:30 AM'},
                    {'status': false, 'time': '9:30 PM'},
                  ],
                },
              ],
              'day': '7',
              'thu': 'THU'
            },
            {'cinemas': [], 'day': '8', 'thu': 'FRI'},
            {
              'cinemas': [
                {
                  'name': 'BHD Star',
                  'showtimes': [
                    {'status': true, 'time': '09:30 AM'},
                    {'status': false, 'time': '11:30 AM'},
                    {'status': true, 'time': '13:30 PM'},
                  ],
                },
                {
                  'name': 'Lotte',
                  'showtimes': [
                    {'status': true, 'time': '4:00 PM'},
                    {'status': true, 'time': '6:00 PM'},
                    {'status': true, 'time': '8:00 PM'},
                  ],
                },
                {
                  'name': 'CGV',
                  'showtimes': [
                    {'status': true, 'time': '7:30 AM'},
                    {'status': false, 'time': '9:30 PM'},
                  ],
                },
                {
                  'name': 'Thắng lợi',
                  'showtimes': [
                    {'status': true, 'time': '7:30 AM'},
                    {'status': true, 'time': '12:30 PM'},
                  ],
                },
              ],
              'day': '9',
              'thu': 'SAT'
            },
            {
              'cinemas': [
                {
                  'name': 'CGV Sinh viên',
                  'showtimes': [
                    {'status': true, 'time': '09:30 AM'},
                    {'status': false, 'time': '10:30 AM'},
                    {'status': false, 'time': '5:30 PM'},
                    {'status': true, 'time': '8:30 PM'},
                  ],
                },
              ],
              'day': '10',
              'thu': 'SUN'
            },
            {
              'cinemas': [
                {
                  'name': 'BHD',
                  'showtimes': [
                    {'status': true, 'time': '4:00 PM'},
                  ],
                },
                {
                  'name': 'CGV',
                  'showtimes': [
                    {'status': true, 'time': '09:30 AM'},
                    {'status': false, 'time': '10:30 AM'},
                    {'status': false, 'time': '5:30 PM'},
                    {'status': true, 'time': '8:30 PM'},
                  ],
                },
              ],
              'day': '11',
              'thu': 'MON'
            },
            {
              'cinemas': [
                {
                  'name': 'Lotte',
                  'showtimes': [
                    {'status': true, 'time': '11:30 AM'},
                  ],
                },
                {
                  'name': 'CGV Sinh viên',
                  'showtimes': [
                    {'status': true, 'time': '4:00 PM'},
                  ],
                },
                {
                  'name': 'CGV',
                  'showtimes': [
                    {'status': true, 'time': '7:30 AM'},
                  ],
                },
              ],
              'day': '12',
              'thu': 'TUE'
            },
            {
              'cinemas': [
                {
                  'name': 'BHD',
                  'showtimes': [
                    {'status': true, 'time': '7:30 AM'},
                    {'status': false, 'time': '9:30 PM'},
                  ],
                },
                {
                  'name': 'CGV',
                  'showtimes': [
                    {'status': true, 'time': '09:30 AM'},
                    {'status': false, 'time': '10:30 AM'},
                    {'status': false, 'time': '5:30 PM'},
                    {'status': true, 'time': '8:30 PM'},
                  ],
                },
              ],
              'day': '13',
              'thu': 'WED'
            },
          ],
          'name': 'Oppenheimer',
          'rate': '8.2',
          'time': '3h 1m',
          'year': '2023',
        })
        .then((value) => print("Movie Added"))
        .catchError((error) => print("Failed to add movie: $error"));
  }
}
