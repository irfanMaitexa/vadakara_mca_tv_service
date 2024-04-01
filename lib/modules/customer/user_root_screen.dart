import 'package:flutter/material.dart';
import 'package:tv_service/modules/customer/customer_added_tv_list.dart';
import 'package:tv_service/modules/customer/customer_booking_list.dart';
import 'package:tv_service/modules/customer/customer_home_screen.dart';
import 'package:tv_service/modules/customer/customer_order_list.dart';
import 'package:tv_service/modules/customer/profile/user_profile_screen.dart';
import 'package:tv_service/utils/constants.dart';

class UserRootScreen extends StatefulWidget {
  const UserRootScreen({super.key});

  @override
  State<UserRootScreen> createState() => _UserRootScreenState();
}

class _UserRootScreenState extends State<UserRootScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _pagesList =  [
    const CustomerHomeScreen(),
    
    const CustomerAddedTvList(),
    
    const CustomerServiceBookingList(),
    const  CustomerOrderBookingList(),
   CustomerProfileScreen(),
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pagesList[_selectedIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
          selectedItemColor: KButtonColor,
          unselectedItemColor: Colors.grey,
          useLegacyColorScheme: false,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
             BottomNavigationBarItem(
              icon: Icon(Icons.tv),
              label: 'Tv',
            ),
            
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Booking',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border),
              label: 'Order',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
