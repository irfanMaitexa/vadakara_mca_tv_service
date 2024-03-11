import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:tv_service/modules/technician/tech_root_screen.dart';
import 'package:tv_service/utils/constants.dart';
import 'package:tv_service/widgets/custom_button.dart';
import 'package:tv_service/widgets/custom_text_field.dart';

class TechyAddRareParts extends StatefulWidget {
  const TechyAddRareParts({super.key});

  @override
  State<TechyAddRareParts> createState() => _TechyAddRarePartsState();
}

class _TechyAddRarePartsState extends State<TechyAddRareParts> {
  final _partsname = TextEditingController();
  final _locationname = TextEditingController();
  final _phoneController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  XFile? image;

  void _getFromCamera() async {
    image = await picker.pickImage(source: ImageSource.camera);
  }

  void _getFromgallary() async {
    image = await picker.pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet:  
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CustomButton(
                        text: "Submit",
                        onPressed: () {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            confirmBtnColor: KButtonColor,
                            onConfirmBtnTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const home_technician(),
                                  ),
                                  (route) => false);
                            },
                          );
                        },
                      ),
                    )
                 
                 ,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20))),
        centerTitle: true,
        title: const Column(
          children: [
            Text(
              "ADD PARTS",
              style: TextStyle(fontSize: 25),
            ),
            Icon(Icons.tv_sharp)
          ],
        ),
        toolbarHeight: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  fixedSize: const Size(150, 50)),
                              onPressed: () {
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  fixedSize: Size(
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                      50)),
                                              onPressed: () {
                                                _getFromCamera();
                                                Navigator.pop(context);
                                              },
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons
                                                      .camera_alt_outlined),
                                                  Text("Take a photo")
                                                ],
                                              )),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  fixedSize: Size(
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                      50)),
                                              onPressed: () {
                                                _getFromgallary();
                                                Navigator.pop(context);
                                              },
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(CupertinoIcons
                                                      .photo_on_rectangle),
                                                  Text("Upload from gallary")
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: const Text("Add photo")),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            onPressed: () {
                              print(image!.path);
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: image == null
                                      ? const Text("upload image")
                                      : Image(
                                          image: FileImage(File(image!.path))),
                                ),
                              );
                            },
                            icon: const Icon(
                              CupertinoIcons.eye,
                              size: 30,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Parts name",
                      style: TextStyle(fontSize: 15),
                    ),
                    CustomTextField(
                        borderColor: Colors.grey.shade300,
                        controller: _partsname,
                        hintText: "Enter parts name"),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Phone number",
                      style: TextStyle(fontSize: 15),
                    ),
                    CustomTextField(
                        borderColor: Colors.grey.shade300,
                        controller: _phoneController,
                        hintText: "Enter phone number"),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Address",
                      style: TextStyle(fontSize: 15),
                    ),
                    CustomTextField(
                      borderColor: Colors.grey.shade300,
                      controller: _locationname,
                      hintText: "Enter Address   with shop name",
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
