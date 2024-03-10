
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:tv_service/modules/technician/tech_root_screen.dart';
import 'package:tv_service/utils/constants.dart';
import 'package:tv_service/widgets/custom_button.dart';
import 'package:tv_service/widgets/custom_text_field.dart';

class TechUsedTvDetailsScreen extends StatefulWidget {
  const TechUsedTvDetailsScreen({super.key, required this.image});


  final  String image;

  @override
  State<TechUsedTvDetailsScreen> createState() => _TechUsedTvDetailsScreenState();
}

class _TechUsedTvDetailsScreenState extends State<TechUsedTvDetailsScreen> {



  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),

       bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(child: CustomButton(
              text: 'Reject',
              color: Colors.redAccent,
              onPressed: () {
                 QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            confirmBtnColor: KButtonColor,
                            onConfirmBtnTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context, 
                                  MaterialPageRoute(builder: (context) => const home_technician(),),
                                   (route) => false);
                            },
                          );
                
              },
            )),
            const SizedBox(width: 10,),
             Expanded(child: CustomButton(

              color: Colors.greenAccent,
              text: 'Accept',
              onPressed: () {

                showDialog(context: context, builder: (context) => AlertDialog(
                  title: const Text('Add commission'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextField(
                        borderColor: Colors.grey,
                        hintText: 'add', controller: _controller
                      ),
                      CustomButton(text: 'Add', onPressed: () {

                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            confirmBtnColor: KButtonColor,
                            onConfirmBtnTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context, 
                                  MaterialPageRoute(builder: (context) => const home_technician(),),
                                   (route) => false);
                            },
                          );
                        
                      },)
                    ],
                  ) ,
                ),);


                
              },
            ))
          ],
          
        ),
      ),
      
      
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(widget.image),
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
                                'Brand',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.grey.shade500),
                              ),
                              const Spacer(),
                              const Text(
                                'samsung',
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
                              Text(
                                'Model no',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.grey.shade500),
                              ),
                              const Spacer(),
                              const Text(
                                '23456789',
                                style:
                                    TextStyle(fontSize: 17, color: Colors.black),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          
                          const Row(
                            children: [
                              Text(
                                'price',
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
      ),
    );
  
  }
}

