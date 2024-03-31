import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:tv_service/modules/customer/user_root_screen.dart';
import 'package:tv_service/services/api_servicces.dart';
import 'package:tv_service/utils/constants.dart';
import 'package:tv_service/widgets/custom_button.dart';
import 'package:tv_service/widgets/custom_text_field.dart';

class CustomerAddUsedTV extends StatefulWidget {
  CustomerAddUsedTV({super.key});

  @override
  State<CustomerAddUsedTV> createState() => _CustomerAddUsedTVState();
}

class _CustomerAddUsedTVState extends State<CustomerAddUsedTV> {
  final _modelname = TextEditingController();
  final _brandlname = TextEditingController();
  final _description = TextEditingController();
  final _color = TextEditingController();
  final _price = TextEditingController();

  bool selectTv1 = false;
  bool selectTv2 = false;
  bool selectTv3 = false;

  bool loading = false;

  String type = '';

  final ImagePicker picker = ImagePicker();
  XFile? image;

  void _getFromCamera() async {
    image = await picker.pickImage(source: ImageSource.camera,imageQuality: 50);
  }

  void _getFromgallary() async {
    image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "ADD USED TV",
              style: TextStyle(fontSize: 25),
            ),
            Icon(Icons.tv_sharp)
          ],
        ),
        toolbarHeight: 100,
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
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
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                OutlinedButton(
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.white,
                                                            fixedSize: Size(
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                50)),
                                                    onPressed: () {
                                                      _getFromCamera();
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
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
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.white,
                                                            fixedSize: Size(
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                50)),
                                                    onPressed: () {
                                                      _getFromgallary();
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(CupertinoIcons
                                                            .photo_on_rectangle),
                                                        Text(
                                                            "Upload from gallary")
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
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: image == null
                                            ? const Text("upload image")
                                            : Image(
                                                image: FileImage(
                                                    File(image!.path))),
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
                            "Brand",
                            style: TextStyle(fontSize: 15),
                          ),
                          CustomTextField(
                              borderColor: Colors.grey.shade300,
                              controller: _brandlname,
                              hintText: "Enter Brand name"),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Color",
                            style: TextStyle(fontSize: 15),
                          ),
                          CustomTextField(
                              borderColor: Colors.grey.shade300,
                              controller: _color,
                              hintText: "Enter color"),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Price",
                            style: TextStyle(fontSize: 15),
                          ),
                          CustomTextField(
                            borderColor: Colors.grey.shade300,
                            controller: _price,
                            hintText: "Enter price",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Model number",
                            style: TextStyle(fontSize: 15),
                          ),
                          CustomTextField(
                            borderColor: Colors.grey.shade300,
                            controller: _modelname,
                            hintText: "Enter model number",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Smart Tv:",
                                style: TextStyle(fontSize: 16),
                              ),
                              Checkbox(
                                activeColor: Colors.amber,
                                value: selectTv1,
                                onChanged: (value) {
                                  selectTv1 = value!;
                                  type = 'smart_tv';
                                  setState(() {});
                                },
                              ),
                              const Text(
                                " Android:",
                                style: TextStyle(fontSize: 16),
                              ),
                              Checkbox(
                                activeColor: Colors.amber,
                                value: selectTv2,
                                onChanged: (value) {
                                  selectTv2 = value!;
                                  type = 'android';
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: _description,
                            minLines: 6,
                            maxLines: 200,
                            decoration: const InputDecoration(
                                hintText: "Add Description....",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: CupertinoColors.inactiveGray)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: CupertinoColors.activeBlue),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CustomButton(
                              text: "Submit",
                              onPressed: () async {
                                try {
                                  setState(() {
                                    loading = true;
                                  });

                                  await ApiServices().addUsedTV(
                                    context,
                                    _brandlname.text,
                                    type,
                                    _modelname.text,
                                    _color.text,
                                    _price.text,
                                    _description.text,
                                    File(
                                      image!.path,
                                    ),
                                  );

                                  setState(() {
                                    loading = false;
                                  });
                                } catch (e) {
                                  setState(() {
                                    loading = false;
                                  });
                                }
                              },
                            ),
                          )
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
