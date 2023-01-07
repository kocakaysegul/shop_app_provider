import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String _userId;

  // Firebase Web API Key: AIzaSyCIBS4CNklJDUDDtW_WmfWvyexpUs01w-Q
  //'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]'
  Future<void> signup(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCIBS4CNklJDUDDtW_WmfWvyexpUs01w-Q');
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
    print(json.decode(response.body));
  }
}
