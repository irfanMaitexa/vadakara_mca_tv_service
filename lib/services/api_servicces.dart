import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiServices{

  static const baseUrl = 'https://alif-electronics-backend.onrender.com';




Future<void> registerUser(BuildContext context, String name, String email, String phone, String password) async {
  // Show loading snack bar
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 16.0),
          Text('Registering user...'),
        ],
      ),
    ),
  );

  final url = Uri.parse('$baseUrl/api/register/user');
  final headers = <String, String>{'Content-Type': 'application/x-www-form-urlencoded'};
  final body = {
    'name': name,
    'email': email,
    'phone': phone,
    'password': password,
  };

  try {
    final response = await http.post(url, headers: headers, body: body);


    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User registered successfully'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to register user. Status code: ${response.statusCode}'),
        ),
      );
    }
  } catch (e) {
    // Hide the loading snack bar
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    print('An error occurred: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('An error occurred: $e'),
      ),
    );
  }
}





}