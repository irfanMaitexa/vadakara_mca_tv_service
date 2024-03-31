import 'package:flutter/material.dart';
import 'package:tv_service/modules/customer/customer_add_address.dart';
import 'package:tv_service/modules/customer/customer_booking_conffirm_screen.dart';
import 'package:tv_service/modules/customer/payment_screen.dart';
import 'package:tv_service/services/api_servicces.dart';
import 'package:tv_service/services/db_services.dart';
import 'package:tv_service/widgets/custom_button.dart';

class UserCheckOutScreen extends StatefulWidget {
  UserCheckOutScreen({
    super.key,
    required this.image,
    required this.serviceName,
    required this.serviceSubTitle,
    required this.price,
    this.date,
  });

  final String image;
  final String serviceName;
  final String serviceSubTitle;
  final dynamic date;
  final String price;

  @override
  State<UserCheckOutScreen> createState() => _UserCheckOutScreenState();
}

class _UserCheckOutScreenState extends State<UserCheckOutScreen> {
  bool ispaid = false;
  bool isAddreess = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Check out'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tv',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: Image.network(
                        widget.image,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.serviceName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          widget.serviceSubTitle,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text(
                    'Adress',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  isAddreess
                      ? Icon(Icons.done)
                      : CustomButton(
                          onPressed: () async {
                            isAddreess = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomerAddAddress(),
                                ));
                            if (isAddreess) {
                              setState(() {});
                            }
                          },
                          text: 'add',
                        ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              const Text(
                'Bill',
                style: TextStyle(color: Colors.black, fontSize: 18),
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
                          widget.serviceName,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.serviceSubTitle,
                          style: TextStyle(
                              fontSize: 17, color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
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
                          '₹${widget.price}',
                          style: TextStyle(fontSize: 17, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    'payment',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  ispaid
                      ? Icon(Icons.done)
                      : CustomButton(
                          onPressed: () async {
                            ispaid = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentScreen(
                                  totalAmount: widget.price,
                                ),
                              ),
                            );

                            if (ispaid) {
                              setState(() {});
                            }
                          },
                          text: 'pay',
                        ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CustomButton(
                  text: 'Place Order',
                  onPressed: () async {
                    if (isAddreess && ispaid) {
                      try {
                        setState(() {
                          loading = true;
                        });

                        ApiServices().placeOrder(
                          context: context,
                          loginId: DbService.getLoginId()!,
                          orderDate:
                              '${DateTime.now().day} -${DateTime.now().month} - ${DateTime.now().year}  ',
                        );

                        setState(() {
                          loading = false;
                        });
                      } catch (e) {}
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Address or payment not complted!!!')));
                    }

                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
