import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tv_service/services/api_servicces.dart';
import 'package:tv_service/widgets/custom_button.dart';
import 'package:tv_service/widgets/custom_text_field.dart';

class TechyAddRareParts extends StatefulWidget {
  const TechyAddRareParts({super.key});

  @override
  State<TechyAddRareParts> createState() => _TechyAddRarePartsState();
}

class _TechyAddRarePartsState extends State<TechyAddRareParts> {



  final _modelname = TextEditingController();
  final _brandlname = TextEditingController();
  final _description = TextEditingController();
  final _color = TextEditingController();
  final _price = TextEditingController();
  final _partController =  TextEditingController();
  final _typeController = TextEditingController();

  bool selectTv1 = false;
  bool selectTv2 = false;
  bool selectTv3 = false;

  bool loading = false;

  String type = '';

  final ImagePicker picker = ImagePicker();
  XFile? image;

  void _getFromCamera() async {
    image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
  }

  void _getFromgallary() async {
    image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
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
          ? const Center(
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
                            "Type",
                            style: TextStyle(fontSize: 15),
                          ),
                          CustomTextField(
                              borderColor: Colors.grey.shade300,
                              controller: _typeController,
                              hintText: "Enter type"),
                          const SizedBox(
                            height: 10,
                          ),

                          const Text(
                            "Part name",
                            style: TextStyle(fontSize: 15),
                          ),
                          CustomTextField(
                              borderColor: Colors.grey.shade300,
                              controller: _partController,
                              hintText: "Enter part name"),
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

                                if(_brandlname.text.isNotEmpty&&image!=null&&_partController.text.isNotEmpty){


                                  ApiServices().addSpareParts(context, {

                                    'brand': _brandlname.text,
                                    'part_name' : _partController.text,
                                    'type' : _typeController.text,
                                    'model' : _modelname.text,
                                    'color' : _color.text,
                                    'price': _price.text,
                                    'description': _description.text,
                                  }, File(image!.path));

                                }else{


                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All fields are required')));
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
