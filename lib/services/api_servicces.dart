// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tv_service/modules/customer/customer_booking_conffirm_screen.dart';
import 'package:tv_service/services/db_services.dart';

class ApiServices {
  static const baseUrl = 'https://alif-electronics-backend.onrender.com';

  Future<void> registerUser(BuildContext context, String name, String email,
      String phone, String password) async {
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
    final headers = <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded'
    };
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
            content: Text(
                'Failed to register user. Status code: ${response.statusCode}'),
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

  Future<int?> loginUser(
      BuildContext context, String email, String password) async {
    // Show loading snack bar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16.0),
            Text('Logging in...'),
          ],
        ),
      ),
    );

    final url = Uri.parse('$baseUrl/api/login');
    final headers = <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    final body = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(url, headers: headers, body: body);

      // Hide the loading snack bar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful'),
          ),
        );

        print(response.body);

        DbService.setLoginId(jsonDecode(response.body)["login_id"]);

        return jsonDecode(response.body)['role'];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${jsonDecode(response.body)['Message']}'),
          ),
        );

        return null;
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

  Future<void> addComplaint({
    required BuildContext context,
    required String loginId,
    required String brand,
    required String model,
    required String complaint,
    required String date,
  }) async {
    // Show loading snack bar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16.0),
            Text('Adding complaint...'),
          ],
        ),
      ),
    );

    final url = Uri.parse('$baseUrl/api/user/add-complaint/$loginId');
    final headers = <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    final body = {
      'brand': brand,
      'model': model,
      'complaint': complaint,
      'date': date,
    };

    try {
      final response = await http.post(url, headers: headers, body: body);

      // Hide the loading snack bar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Complaint added successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to add complaint. Status code: ${response.statusCode}'),
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

  Future<List<dynamic>> getUserComplaints(
      BuildContext context, String loginId) async {
    // Show loading snack bar

    final url = Uri.parse('$baseUrl/api/user/view-complaint/$loginId');

    try {
      final response = await http.get(url);

      print(response.statusCode);

      // Hide the loading snack bar

      if (response.statusCode == 201) {
        print(response.body);
        List<dynamic> data = jsonDecode(response.body)['data'];

        return data;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addUsedTV(
      BuildContext context,
      String brand,
      String type,
      String model,
      String color,
      String price,
      String description,
      File image) async {
    // Show loading snack bar
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16.0),
              Text('Adding used TV...'),
            ],
          ),
        ),
      );
    }

    final url = Uri.parse('$baseUrl/api/user/add-used-tv');

    print(url);

    // Create a multipart request
    var request = http.MultipartRequest('POST', url);

    // Add fields to the request
    request.fields['brand'] = brand;
    request.fields['type'] = type;
    request.fields['model'] = model;
    request.fields['color'] = color;
    request.fields['price'] = price.toString();
    request.fields['description'] = description;

    print('image');

    var imageFile = await http.MultipartFile.fromPath('image', image.path);

    request.files.add(imageFile);

    try {
      var response = await request.send();

      // Hide the loading snack bar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Used TV added successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to add used TV. Status code: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      // Hide the loading snack bar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
    }
  }

//
  Future<List<dynamic>> fetchUsedTVs() async {
    final response =
        await http.get(Uri.parse('$baseUrl/api/user/view-used-tv'));

    if (response.statusCode == 201) {
      return jsonDecode(response.body)['data'];
    } else {
      print(response.statusCode);
      throw Exception('Failed to fetch used TVs');
    }
  }

  //user add address

  Future<void> addAddress({
    required BuildContext context,
    required String loginId,
    required String address,
    required String pincode,
    required String state,
    required String city,
    required String landmark,
    required String name,
    required String phone,
  }) async {
    // Show loading snack bar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16.0),
            Text('Adding address...'),
          ],
        ),
      ),
    );

    final url = Uri.parse('$baseUrl/api/user/add-address/$loginId');
    final body = {
      'address': address,
      'pincode': pincode,
      'state': state,
      'city': city,
      'landmark': landmark,
      'name': name,
      'phone': phone,
    };

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      );

      // Hide the loading snack bar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (response.statusCode == 201) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Address added successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to add address. Status code: ${response.statusCode}'),
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

  Future<void> placeOrder(
      {required BuildContext context,
      required String loginId,
      required String orderDate}) async {
    // Show loading snack bar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16.0),
            Text('Placing order...'),
          ],
        ),
      ),
    );

    final url = Uri.parse('$baseUrl/api/user/place-order-prod/$loginId');
    final body = {'order_date': DateTime.now().toString()};
    print(url);

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      );

      print(url);

      // Hide the loading snack bar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CustomerBookingConfirmScreen(),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Order placed successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to place order. Status code: ${response.statusCode}'),
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

  //fetch api
  Future<List<dynamic>> fetchUserOrders(String loginId) async {
    final url = Uri.parse('$baseUrl/api/user/view-order/$loginId');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body)['Data'];
      } else {
        throw Exception(
            'Failed to fetch user orders. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch user orders. Error: $e');
    }
  }

  //add used tv staff

  Future<void> addUsedTVStaff({
    required BuildContext context,
    required String brand,
    required String type,
    required String model,
    required String color,
    required String price,
    required String description,
    required String image,
  }) async {
    // Show loading snack bar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16.0),
            Text('Adding used TV...'),
          ],
        ),
      ),
    );

    final url = Uri.parse('$baseUrl/api/staff/add-used-tv');

    print(url);

    // Create a multipart request
    var request = http.MultipartRequest('POST', url);

    print(price);

    // Add fields to the request
    request.fields['brand'] = brand;
    request.fields['type'] = type;
    request.fields['model'] = model;
    request.fields['color'] = color;
    request.fields['price'] = price;
    request.fields['description'] = description;

    var imageFile = await http.MultipartFile.fromPath('image', image);

    request.files.add(imageFile);

    try {
      var response = await request.send();
      final responseData = await response.stream.bytesToString();
      final parsedData = json.decode(responseData);

      // Hide the loading snack bar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Used TV added successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to add used TV. Status code: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      // Hide the loading snack bar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
    }
  }

  //
  Future<void> updateComplaintStatus(
      BuildContext context, String id, String bookedDate) async {
    final url =
        Uri.parse('$baseUrl/api/staff/update-complaint-stat/$id/$bookedDate');

    try {
      final response = await http.put(url);

      if (response.statusCode == 200) {
        // Request successful, handle response
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Complaint status updated successfully'),
        ));
      } else {
        // Request failed with a non-200 status code
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('Failed to update complaint status: ${response.statusCode}'),
        ));
      }
    } catch (e) {
      // Request failed
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update complaint status: $e'),
      ));
    }
  }


  //

  Future<void> updateServiceStatusTech(BuildContext context, String id, String bookedDate) async {
  final url = Uri.parse('$baseUrl/api/technician/update-complaint-stat/$id/$bookedDate');

  print('hhhh$url');

 

  try {


   

  

     // Show snack bar with loading indicator
  const snackBar = SnackBar(
    content: Row(
      children: [
        CircularProgressIndicator(),
        SizedBox(width: 20),
        Text('Updating service status...'),
      ],
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);

    // Hide snack bar
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

     final response = await http.put(url);

     print('asdfghj');

     print(response.body);

    if (response.statusCode == 200) {
      // Request successful, handle response
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Service status updated successfully'),
      ));
    } else {
      // Request failed with a non-200 status code
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update service status: ${response.statusCode}'),
      ));
    }
  } catch (e) {
    // Request failed
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Failed to update service status: $e'),
    ));
  }
}

//add rare parts
Future<void> addSpareParts(BuildContext context, Map<String, dynamic> data, File imageFile) async {
  final url = Uri.parse('$baseUrl/api/technician/add-spareparts');

  // Show snack bar with loading indicator
  const snackBar =  SnackBar(
    content: Row(
      children: [
        CircularProgressIndicator(),
        SizedBox(width: 20),
        Text('Adding spare parts...'),
      ],
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);

  try {
    // Create a multipart request
    var request = http.MultipartRequest('POST', url);

    // Add each parameter directly to the request
    request.fields['brand'] = data['brand'].toString();
    request.fields['part_name'] = data['part_name'].toString();
    request.fields['type'] = data['type'].toString();
    request.fields['model'] = data['model'].toString();
    request.fields['color'] = data['color'].toString();
    request.fields['price'] = data['price'].toString();
    request.fields['description'] = data['description'].toString();

    // Add the image file to the request
    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
    }

    // Send the request
    var response = await request.send();

   



    if (response.statusCode == 201) {
      // Request successful, handle response
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Spare parts added successfully'),


      ));

      Navigator.pop(context);
    } else {
      // Request failed with a non-200 status code
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add spare parts: ${response.statusCode}'),
      ));
    }
  } catch (e) {
    // Request failed
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Failed to add spare parts: $e'),
    ));
  }
}


Future<Map<String, dynamic>> fetchUserProfile() async {
    final response =
        await http.get(Uri.parse('$baseUrl/api/profile/user/${DbService.getLoginId()}'));

    if (response.statusCode == 200) {

      print(json.decode(response.body)['data'][0]);
      
      return json.decode(response.body)['data'][0];
    } else {
      throw Exception('Failed to fetch user profile');
    }
  }

}



