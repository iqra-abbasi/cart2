import 'package:flutter/material.dart';

class CartDropDownController extends ChangeNotifier {
  String dropdownvalue = "customized";

  void changeCustomizedDropDown(String value) {
    dropdownvalue = value;
    notifyListeners();
  }



}
