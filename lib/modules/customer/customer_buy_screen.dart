import 'package:flutter/material.dart';
import 'package:tv_service/widgets/custom_button.dart';

class CustomerBuyScreen extends StatelessWidget {
  const CustomerBuyScreen({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomSheet: CustomButton(
        onPressed: () {},
        text: 'Check Out',
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
                              'Size',
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                            const Spacer(),
                            const Text(
                              '100',
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
                              'Serviece charge',
                              style: TextStyle(
                                  fontSize: 17, color: Colors.grey.shade500),
                            ),
                            const Spacer(),
                            const Text(
                              '100',
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
          ))
        ],
      ),
    );
  
  }
}
