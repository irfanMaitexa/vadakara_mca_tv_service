import 'package:flutter/material.dart';
import 'package:tv_service/services/api_servicces.dart';
import 'package:tv_service/services/db_services.dart';
import 'package:tv_service/widgets/custom_button.dart';
import 'package:tv_service/widgets/custom_text_field.dart';

class CustomerAddAddress extends StatefulWidget {
  const CustomerAddAddress({super.key});

  @override
  State<CustomerAddAddress> createState() => _CustomerAddAddressState();
}

class _CustomerAddAddressState extends State<CustomerAddAddress> {
  final _addressController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _landMarkController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Address'),
        centerTitle: true,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      hintText: 'name',
                      controller: _nameController,
                      borderColor: Colors.grey,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      hintText: 'phone',
                      controller: _phoneController,
                      borderColor: Colors.grey,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      hintText: 'city',
                      controller: _cityController,
                      borderColor: Colors.grey,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      hintText: 'landmark',
                      controller: _landMarkController,
                      borderColor: Colors.grey,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      hintText: 'state',
                      controller: _stateController,
                      borderColor: Colors.grey,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      hintText: 'address',
                      controller: _addressController,
                      borderColor: Colors.grey,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      hintText: 'pincode',
                      controller: _pincodeController,
                      borderColor: Colors.grey,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CustomButton(
                        text: 'Add',
                        onPressed: () async {
                          if (_addressController.text.isNotEmpty &&
                              _cityController.text.isNotEmpty &&
                              _phoneController.text.isNotEmpty) {
                            setState(() {
                              loading = true;
                            });

                            await ApiServices().addAddress(
                                context: context,
                                loginId: DbService.getLoginId()!,
                                address: _addressController.text,
                                pincode: _pincodeController.text,
                                state: _stateController.text,
                                city: _cityController.text,
                                landmark: _landMarkController.text,
                                name: _nameController.text,
                                phone: _phoneController.text);

                            setState(() {
                              loading = false;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('All fields are required'),
                              ),
                            );
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
