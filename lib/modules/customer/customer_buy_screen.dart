import 'package:flutter/material.dart';
import 'package:tv_service/modules/customer/customer_check_out_screen.dart';
import 'package:tv_service/widgets/custom_button.dart';

class CustomerBuyScreen extends StatelessWidget {
  const CustomerBuyScreen(
      {super.key, required this.image, required this.details});

  final String image;
  final Map<String, dynamic> details;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomSheet: SizedBox(
        width: MediaQuery.of(context).size.width - 50,
        child: CustomButton(
          onPressed: () {

            Navigator.push(context, MaterialPageRoute(builder: (context) => UserCheckOutScreen(
              image: details['image'],
              serviceName: details['brand'],
              serviceSubTitle: details['model'],
              price: details['price'].toString(),
            ),));

          },
          text: 'Check Out',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(image),
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Card(
              child: Column(
                children: [
                  const Text(
                    'Specification',
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
                              'Type',
                              style: TextStyle(
                                  fontSize: 17, color: Colors.grey.shade500),
                            ),
                            const Spacer(),
                            Text(
                              details['type'],
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
                        const SizedBox(
                          height: 20,
                        ),
                        
                        Row(
                          children: [
                            const Text(
                              'Model',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            Text(
                              details['model'],
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.black),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Color',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            Text(
                              details['color'],
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.black),
                            ),
                          ],
                        ),
                        const  SizedBox(height: 20,),
                        Column(
                          children: [
                            const Text(
                              'Description',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                             SizedBox(height: 20,),
                            Text(
                              details['description'],
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.black),
                            ),
                          ],
                        ),

                        SizedBox(height: 20,),
                        Row(
                          children: [
                            const Text(
                              'Price',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            Text(
                              details['price'].toString(),
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.black),
                            ),
                          ],
                        ),
                        const  SizedBox(height: 60,),


                        
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
