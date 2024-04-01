import 'package:flutter/material.dart';
import 'package:tv_service/modules/auth/login.dart';
import 'package:tv_service/modules/customer/profile/user_edit_profile_screen.dart';
import 'package:tv_service/modules/customer/user_root_screen.dart';
import 'package:tv_service/services/api_servicces.dart';
import 'package:tv_service/utils/constants.dart';
import 'package:tv_service/widgets/custom_button.dart';
import 'package:tv_service/widgets/custom_text_field.dart';

class CustomerProfileScreen extends StatelessWidget {
  CustomerProfileScreen({super.key});

  TextEditingController _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: ApiServices().fetchUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            var profileData = snapshot.data!;
            print(profileData);

            _nameController.text = profileData['name'];
            _emailController.text = profileData['email'];
            _phoneController.text = profileData['phone'];

            return Center(
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserEditProfileScreen(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 30,
                          color: KButtonColor,
                        ),
                      )
                    ],
                  ),
                  const CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomTextField(
                      hintText: 'name',
                      controller: _nameController,
                      isEnabled: false,
                      borderColor: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomTextField(
                      hintText: 'email',
                      controller: _emailController,
                      isEnabled: false,
                      borderColor: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomTextField(
                      hintText: 'phone',
                      controller: _phoneController,
                      isEnabled: false,
                      borderColor: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    child: CustomButton(
                      text: 'Log out',
                      color: KButtonColor,
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false);
                      },
                    ),
                  )
                ],
              ),
            );
          }
        });
  }
}
