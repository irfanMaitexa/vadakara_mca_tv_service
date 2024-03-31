import 'package:flutter/material.dart';
import 'package:tv_service/modules/customer/customer_buy_screen.dart';
import 'package:tv_service/modules/customer/user_booking_screen.dart';
import 'package:tv_service/services/api_servicces.dart';
import 'package:tv_service/utils/constants.dart';
import 'package:tv_service/widgets/custom_button.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final serviceList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrJ468ITU70SviByi71ALsK0XKruzALn6efA&usqp=CAU',
    'https://st2.depositphotos.com/1346781/11257/i/450/depositphotos_112571424-stock-photo-an-electronics-repair-shop-technician.jpg'
  ];

  final tvList = [
    'https://static.vecteezy.com/system/resources/thumbnails/001/558/661/small/realistic-flat-tv-screen-vector.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYIzSohHeL_WwOIx7U-wG4NX1D8Ma_3Wi75g&usqp=CAU',
    'https://static.vecteezy.com/system/resources/thumbnails/001/558/661/small/realistic-flat-tv-screen-vector.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: KButtonColor,
                      borderRadius: BorderRadius.circular(30)),
                ),
                Positioned(
                    top: 85,
                    right: 20,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            suffixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              gapPadding: 0,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                    )),
                Positioned(
                  bottom: -50,
                  left: 20,
                  right: 20,
                  child: Stack(
                    children: [
                      Image.asset('assets/images/BannerImage.png'),
                      const Positioned(
                        top: 20,
                        left: 20,
                        child: Text(
                          'Your TV Repair\n Specialists',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Select your service',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                        itemCount: serviceList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 150,
                                margin: const EdgeInsets.only(left: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        color: Colors.grey.shade200)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        serviceList[index],
                                        fit: BoxFit.cover,
                                        height: 100,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Tv repair',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: CustomButton(
                                              text: 'Book now',
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserServiceBookingScreen(
                                                        images:
                                                            serviceList[index],
                                                      ),
                                                    ));
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                  ),
                  const Text(
                    'Buy TV',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),


                  FutureBuilder(
      future: ApiServices().fetchUsedTVs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<dynamic> tvList = snapshot.data ?? [] ;
          
          return SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tvList.length,
              itemBuilder: (context, index) {
                var tv = tvList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomerBuyScreen(
                          image: tv['image'],
                          details: tv
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 150,
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            tv['image'],
                            fit: BoxFit.fill,
                            height: 100,
                            width: double.maxFinite,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tv['brand'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '₹${tv['price']}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: CustomButton(
                                  text: 'Buy now',
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    )
                  
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
