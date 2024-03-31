import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:intl/intl.dart';
import 'package:tv_service/modules/customer/customer_check_out_screen.dart';
import 'package:tv_service/services/api_servicces.dart';
import 'package:tv_service/services/db_services.dart';
import 'package:tv_service/widgets/custom_button.dart';
import 'package:tv_service/utils/constants.dart';
import 'package:tv_service/widgets/custom_text_field.dart';

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

  final _brandcontroller = TextEditingController();
  final _complaintController = TextEditingController();
  final _modelController = TextEditingController();
   bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading ? Center(child: CircularProgressIndicator(),)  : SizedBox(
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
                      CustomTextField(
                         borderColor: Colors.grey,
                          hintText: 'Brand', controller: _brandcontroller),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        hintText: 'Model',
                        controller: _modelController,
                         borderColor: Colors.grey,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                          hintText: 'Complaint',
                          borderColor: Colors.grey,
                          maxline: 30,
                          minLine: 6,
                          controller: _complaintController),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CustomButton(
                          text: 'Book now',
                          onPressed: () async{

                            try{


                              setState(() {
                                loading =  true;
                              });


                              await ApiServices().addComplaint(
                                context: context, 
                                loginId: DbService.getLoginId()!, 
                                brand: _brandcontroller.text, 
                                model: _modelController.text, 
                                complaint: _complaintController.text, 
                                date: DateFormat('dd-MM-yyyy').format(_selectedDate)
                                );


                                Navigator.pop(context);

                              setState(() {
                                loading = false;
                              });

                            }catch(e){

                              setState(() {
                                loading =  false;
                              });

                            }


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
