import 'dart:math';

import 'package:book_my_seat/book_my_seat.dart';

class Seats {
  final int rows;
  final int cols;
  final int seatPrice = 2;
  List<List<SeatState>> seatGrid = [];

  Seats({required this.rows, required this.cols}) {
    initializeSeatGrid();
  }

  void initializeSeatGrid() {
    // Initialize seatGrid with empty seats
    seatGrid = List.generate(rows, (row) {
      return List.generate(cols, (col) {
        return SeatState.selected;
      });
    });

    // Set specific seat states as mentioned in the requirements
    seatGrid[0][0] = SeatState.empty;
    seatGrid[0][1] = SeatState.empty;
    seatGrid[1][0] = SeatState.empty;

    seatGrid[0][10] = SeatState.empty;
    seatGrid[0][11] = SeatState.empty;
    seatGrid[1][11] = SeatState.empty;

    for (int i = 0; i < 3; i++) {
      seatGrid[5][i] = SeatState.empty;
      seatGrid[5][9 + i] = SeatState.empty;
    }

    for (int i = 0; i < 12; i++) {
      seatGrid[i][3] = SeatState.empty;
      seatGrid[i][8] = SeatState.empty;
    }

    // Set the remaining seats randomly
    Random random = Random();
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (seatGrid[i][j] != SeatState.empty) {
          seatGrid[i][j] =
              random.nextBool() ? SeatState.sold : SeatState.unselected;
        }
      }
    }
  }

  int totalPrice(){
    int price = 0;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (seatGrid[i][j] == SeatState.selected) {
          price += seatPrice;
          print(price);
        }
      }
    }
    return price;
  }

  int countSelected(){
    int count = 0;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (seatGrid[i][j] == SeatState.selected) {
          count += 1;
        }
      }
    }
    return count;
  }
}
