import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:tv_service/modules/customer/customer_check_out_screen.dart';
import 'package:tv_service/widgets/custom_button.dart';
import 'package:tv_service/utils/constants.dart';


class UserServiceBookingScreen extends StatefulWidget {
  const UserServiceBookingScreen({Key? key, required this.images})
      : super(key: key);

  final String images;

  @override
  State<UserServiceBookingScreen> createState() =>
      _UserServiceBookingScreenState();
}

class _UserServiceBookingScreenState extends State<UserServiceBookingScreen> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.6,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.images,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: 30,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 3,
              child: Container(
                padding: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Description',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'TV repair involves diagnosing and fixing issues with televisions, such as problems with the display, sound, power supply, and connectivity, using specialized tools and electronics knowledge.',
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Date',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      DatePicker(
                        DateTime.now(),
                        height: 100,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: KButtonColor,
                        selectedTextColor: Colors.white,
                        onDateChange: (date) {
                          // New date selected
                          setState(() {
                            _selectedDate = date;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Time',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () async {
                              final TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (picked != null && picked != _selectedTime) {
                                setState(() {
                                  _selectedTime = picked;
                                
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                '${_selectedTime.format(context)}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CustomButton(
                          text: 'Proceed',
                          onPressed: () {
                            // QuickAlert.show(
                            //   context: context,
                            //   type: QuickAlertType.success,
                            //   confirmBtnColor: KButtonColor,
                            //   onConfirmBtnTap: () {
                                
                            //   },
                            // );
                            Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserCheckOutScreen(
                                            image: '',
                                            serviceName: 'service name',
                                            serviceSubTitle: 'service',
                                          )),
                                );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
