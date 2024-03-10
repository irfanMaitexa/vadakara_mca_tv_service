import 'package:flutter/material.dart';
import 'package:tv_service/modules/customer/user_root_screen.dart';
import 'package:tv_service/widgets/custom_button.dart';

class CustomerBookingConfirmScreen extends StatefulWidget {
  const CustomerBookingConfirmScreen({super.key});

  @override
  State<CustomerBookingConfirmScreen> createState() =>
      _CustomerBookingConfirmScreenState();
}

class _CustomerBookingConfirmScreenState
    extends State<CustomerBookingConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 70,
              color: Colors.green,
            ),
            SizedBox(
              height: 20,
            ),
            const Text(
              'Booking Confirmed',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            const Text(
              'Your booking has been \nsuccessfully confirmed!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              text: 'Ok',
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserRootScreen(),
                    ),
                    (route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}
