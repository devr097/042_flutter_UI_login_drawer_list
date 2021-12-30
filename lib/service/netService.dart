import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sgmbooking/models/bookModel.dart';
import 'package:sgmbooking/service/my_api.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class NetworkBloc extends ChangeNotifier {

  bool _hasError = false;
  bool get hasError => _hasError;

  String? _errorCode;
  String? get errorCode => _errorCode;

  bool _guestUser = false;
  bool get guestUser => _guestUser;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  BookModel _bookData = BookModel(count: 0, next: "", previous: "", results: []);
  BookModel get bookData => _bookData;

  Future guestSignout() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('guest_user', false);
    _guestUser = false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('signed_in', true);
    _isSignedIn = true;
    notifyListeners();
  }

  Future signInwithEmailPassword(userEmail, userPassword) async {
    // try {
    print("------------------------005");
    var data = {
      'username': userEmail,
      'password': userPassword,
    };

    var res = await CallApi().postData(data, 'rest/v1/obtain-token/');
    var body = json.decode(res.body);

    print(["login response:",res,body,res.statusCode]);

    if (res.statusCode == 201) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);

      var enUser = json.encode(body['pk']);
      var deUser = json.decode(enUser);

      _hasError = false;
      notifyListeners();
    } else if (res.statusCode == 401) {
      _hasError = true;
      _errorCode = body['non_field_errors'];
      notifyListeners();
    }else if(res.statusCode == 400){
      _hasError = true;
      _errorCode = body['non_field_errors'][0];
    }
    else {
      _hasError = true;
      if (body['password'] == null)
        _errorCode = body['email'];
      else
        _errorCode = body['password'];
      notifyListeners();
    }
  }

  Future<bool> getBooking()async{
    var res = await CallApi().getDataParameterWithToken('rest/v1/travel/',"");
    if(res.statusCode==200){

      var body = json.decode(res.body);
      _bookData = BookModel.fromJson(body);
    }


    notifyListeners();

    return true;
  }

}