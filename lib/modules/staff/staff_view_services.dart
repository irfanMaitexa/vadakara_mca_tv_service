import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tv_service/services/api_servicces.dart';
import 'package:tv_service/widgets/custom_button.dart';

class StaffViewServices extends StatefulWidget {
  @override
  _StaffViewServicesState createState() => _StaffViewServicesState();
}

class _StaffViewServicesState extends State<StaffViewServices> {
  int _currentIndex = 0;

  List<dynamic> pendingComplaints = [];
  List<dynamic> completedComplaints = [];
  List<dynamic> confirmedComplaints = [];

  bool loading =  false;

  @override
  void initState() {
    super.initState();
    fetchComplaints();
  }

  Future<void> fetchComplaints() async {
    final url =
        Uri.parse('${ApiServices.baseUrl}/api/technician/view-complaint');


    setState(() {
      loading =  true;
    });

    try {
      final response = await http.get(url);

      if (response.statusCode == 201) {
        // Request successful, handle response
        final List<dynamic> data = json.decode(response.body)['data'];

        print(data);
        setState(() {
          pendingComplaints = data
              .where((complaint) => complaint['status'] == 'pending')
              .toList();
          completedComplaints = data
              .where((complaint) => complaint['status'] == 'completed')
              .toList();
          confirmedComplaints = data
              .where((complaint) => complaint['status'] == 'confirmed')
              .toList();

          

        loading = false;
        });
      } else {

        setState(() {
          loading = false;
        });
        // Request failed with a non-200 status code
        print('Failed to fetch complaints: ${response.statusCode}');
      }
    } catch (e) {

      setState(() {
        loading =  false;
      });
      // Request failed
      print('Failed to fetch complaints: $e');
    }

    
  }

  

  @override
  Widget build(BuildContext context) {
    return loading ?  Scaffold(body: Center(child: CircularProgressIndicator(),),) : DefaultTabController(
      length: 3, // Changed length to 3 for the new "Confirm" tab
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Text('Pending'),
              ),
              Tab(
                icon: Text('Confirmed'),
              ),
              Tab(
                icon: Text('Completed'), // Added a new tab for "Confirm"
              ),
            ],
          ),
          title: const Text('Bookings'),
        ),
        body: TabBarView(
          children: [
            //tab bar pending
            ListView.builder(
              itemCount: pendingComplaints.length,
              itemBuilder: (context, index) => TvComplaintCard(
                status: 'pending',
                buttonText: 'Confirm',
                details: pendingComplaints[index],
                onTab: () async{
                  

                    

                    await ApiServices().updateComplaintStatus(context, pendingComplaints[index]['_id'], pendingComplaints[index]['date']);

                    fetchComplaints();
                },
              ),
            ),

             //tab bar Confirm
            ListView.builder(
              itemCount: confirmedComplaints.length,
              itemBuilder: (context, index) => TvComplaintCard(
                status: 'Confirmed',
                buttonText: 'Confirm',
                details: confirmedComplaints[index],
                onTab: () {
                  print('Confirmed: ${confirmedComplaints[index]}');
                },
              ),
            ),

            //tab bar Completed
            ListView.builder(
              itemCount: completedComplaints.length,
              itemBuilder: (context, index) => TvComplaintCard(
                status: 'Completed',
                buttonText: 'Completed',
                details: completedComplaints[index],
                onTab: () {
                 
                },
              ),
            ),

           
          ],
        ),
      ),
    );
  }
}

class TvComplaintCard extends StatelessWidget {
  const TvComplaintCard({
    Key? key,
    required this.status,
    required this.buttonText,
    required this.onTab, required this.details,
  }) : super(key: key);

  final String status;
  final String buttonText;
  final VoidCallback onTab;

  final  Map<String,dynamic> details;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrJ468ITU70SviByi71ALsK0XKruzALn6efA&usqp=CAU',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                 Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.settings_accessibility),
                          Text(details['name']),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(Icons.settings_suggest),
                          Text(details['brand']),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(Icons.phone),
                          Text(details['phone']),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_month),
                          Text(details['date']),
                        ],
                      ),
                      SizedBox(
                        height: 5),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if (status != 'Completed')
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CustomButton(
                  text: buttonText,
                  onPressed: onTab,
                ),
              )
          ],
        ),
      ),
    );
  }
}
