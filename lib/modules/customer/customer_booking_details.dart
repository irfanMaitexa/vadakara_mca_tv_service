import 'package:flutter/material.dart';

class CustomerBookingDetails extends StatelessWidget {
  const CustomerBookingDetails({super.key, required this.image, required this.details});

  final String image;
  final Map<String,dynamic> details;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
     
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  image,
                  fit: BoxFit.fill,
                  ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Card(
                child: Column(
                  children: [
                    const Text(
                      'Details',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Brand',
                                style: TextStyle(color: Colors.grey.shade500),
                              ),
                              const Spacer(),
                               Text(
                                details['brand'],
                                style:
                                    TextStyle(fontSize: 17, color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Date',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.grey.shade500),
                              ),
                              const Spacer(),
                               Text(
                                details['date'],
                                style:
                                    TextStyle(fontSize: 17, color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Model',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.grey.shade500),
                              ),
                              const Spacer(),
                               Text(
                                details['model'],
                                style:
                                    TextStyle(fontSize: 17, color: Colors.black),
                              ),
                            ],
                          ),const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Status',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.grey.shade500),
                              ),
                              const Spacer(),
                               Text(
                                details['status'],
                                style:
                                    TextStyle(fontSize: 17, color: Colors.black),
                              ),
                            ],
                          ),
            
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                'Complaints',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.grey.shade500),
                              ),
                              SizedBox(height: 10,),
                               Text(
                                details['complaint'],
                                style:
                                    TextStyle(fontSize: 17, color: Colors.black),
                              ),
                            ],
                          ),
                          
                          
                          
                          
                          
                          
                          
                          
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              Text(
                                '₹100',
                                style:
                                    TextStyle(fontSize: 17, color: Colors.black),
                              ),
                            ],
                          ),
                       
                       
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
