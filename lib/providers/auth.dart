import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shop_app_provider/models/http_exception.dart';

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String _userId;

  // Firebase Web API Key: AIzaSyCIBS4CNklJDUDDtW_WmfWvyexpUs01w-Q
  //'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]'
  //'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCIBS4CNklJDUDDtW_WmfWvyexpUs01w-Q'

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
    Uri.parse('https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=AIzaSyCIBS4CNklJDUDDtW_WmfWvyexpUs01w-Q');
    try{
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      //print(json.decode(response.body));
      final responseData = json.decode(response.body);
      if(responseData['error'] != null){
        throw HttpException(responseData['error']['message']);
      }

    } catch (error) {
      throw error;
    }

  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signupNewUser');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'verifyPassword');
  }
}