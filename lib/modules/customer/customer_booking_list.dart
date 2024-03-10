import 'package:flutter/material.dart';
import 'package:tv_service/modules/customer/customer_booking_details.dart';



class CustomerServiceBookingList extends StatefulWidget {
  const CustomerServiceBookingList({super.key});

  @override
  State<CustomerServiceBookingList> createState() =>
      _CustomerServiceBookingListState();
}

class _CustomerServiceBookingListState extends State<CustomerServiceBookingList> {

   final List bookingHistory = [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrJ468ITU70SviByi71ALsK0XKruzALn6efA&usqp=CAU',

    
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          title: const Text('Bookings'),
          centerTitle: true,
        ),
        Expanded(
            child: ListView.builder(
               itemCount: bookingHistory.length,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          )),
                      child: ListTile(
                        onTap: () {

                          Navigator.push(context,MaterialPageRoute(builder: (context) => CustomerBookingDetails(image: bookingHistory[index])

                          ,),);
                        },

                        leading:  ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: 
                         NetworkImage(bookingHistory[index])
                     
                  ),
                ),
                        title: const Text(
                          'Name',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        subtitle: const Text('booking time'),
                        trailing: IconButton(onPressed: () {

                          



                          
                        }, icon: Icon(Icons.arrow_circle_right))
                      ),
                    )))
      ],
    );
  }
}