import 'package:flutter/material.dart';
import 'package:tv_service/modules/customer/user_root_screen.dart';

class CustomerViewBookingDetails extends StatelessWidget {
   CustomerViewBookingDetails({Key ? key}) : super(key: key);

  final List bookingHistory = [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrJ468ITU70SviByi71ALsK0XKruzALn6efA&usqp=CAU',

    
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => UserRootScreen()),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Your bookings'),
        ),
        body: ListView.builder(
          itemCount: bookingHistory.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.white,
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: 
                         NetworkImage(bookingHistory[index])
                     
                  ),
                ),
                title: Text('Service name'),
                
                // You can customize the ListTile further as needed
              ),
            );
          },
        ),
      ),
    );
  }
}