import 'package:flutter/material.dart';
import 'package:tv_service/modules/auth/user_registration.dart';
import 'package:tv_service/modules/customer/user_root_screen.dart';
import 'package:tv_service/modules/staff/staff_root_screen.dart';
import 'package:tv_service/modules/technician/tech_root_screen.dart';
import 'package:tv_service/services/api_servicces.dart';
import 'package:tv_service/utils/constants.dart';
import 'package:tv_service/utils/validator.dart';
import 'package:tv_service/widgets/custom_button.dart';
import 'package:tv_service/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(color: Colors.white),
  );

  String? emailError;
  String? passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Login',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body:loading ? Center(child: CircularProgressIndicator(),) : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                CustomTextField(
                  hintText: 'Enter Email',
                  controller: _emailController,
                  borderColor: Colors.grey.shade300,
                  validator: (value) {
                    return validateEmail(value);
                  },
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  hintText: 'Enter password',
                  controller: _passwordController,
                  errorText: passwordError,
                  obscureText: _obscureText,
                  borderColor: Colors.grey.shade300,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  validator: (value) => validatePassword(value),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forget password',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: CustomButton(
                    text: 'LOG IN',
                    color: KButtonColor,
                    onPressed: () {
                      _loginHandler();
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Dont have an account?',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const UserRegistrationScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: KButtonColor, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool loading = false;

  void _loginHandler() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      var role = await ApiServices()
          .loginUser(context, _emailController.text, _passwordController.text);

      print(role == 2);

      if (role == 2) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => UserRootScreen(),
            ),
            (route) => false);
      }

      if (_emailController.text.trim() == 'techy@gmail.com') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => home_technician(),
            ),
            (route) => false);
      }
      if (_emailController.text.trim() == 'staff@gmail.com') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => StaffRootScreen(),
            ),
            (route) => false);
      }
    }

    setState(() {
      loading =  false;
    });
  }


  
}
