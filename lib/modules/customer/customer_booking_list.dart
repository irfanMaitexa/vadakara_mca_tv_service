import 'package:flutter/material.dart';
import 'package:tv_service/modules/customer/customer_booking_details.dart';
import 'package:tv_service/services/api_servicces.dart';

import 'package:tv_service/services/db_services.dart';

class CustomerServiceBookingList extends StatefulWidget {
  const CustomerServiceBookingList({Key? key}) : super(key: key);

  @override
  State<CustomerServiceBookingList> createState() =>
      _CustomerServiceBookingListState();
}

class _CustomerServiceBookingListState
    extends State<CustomerServiceBookingList> {
  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder<dynamic>(
      future: ApiServices().getUserComplaints(context, DbService.getLoginId()!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<dynamic> bookings = snapshot.data ?? [];
          print(snapshot.data);
          return Column(
            children: [
              AppBar(
                backgroundColor: Colors.white,
                title: const Text('Bookings'),
                centerTitle: true,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: bookings.length,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomerBookingDetails(
                              details:bookings[index],
                              image:'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrJ468ITU70SviByi71ALsK0XKruzALn6efA&usqp=CAU',
                            ),
                          ),
                        );
                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrJ468ITU70SviByi71ALsK0XKruzALn6efA&usqp=CAU'),
                      ),
                      title: Text(
                        bookings[index]['brand'],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(bookings[index]['date']),
                      trailing: IconButton(
                        onPressed: () {
                          // Handle trailing icon button press
                        },
                        icon: const Icon(Icons.arrow_circle_right),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
