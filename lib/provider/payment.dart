import 'package:flutter/material.dart';

class Payment extends ChangeNotifier {
  int amount = 500;

  void makePayment() {
    this.amount = this.amount - 80;
    notifyListeners();
  }
}
