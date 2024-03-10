import 'package:flutter/material.dart';
import 'package:tv_service/modules/customer/customer_add_tv.dart';
import 'package:tv_service/modules/customer/user_added_tv_details.dart';
import 'package:tv_service/widgets/custom_button.dart';

class CustomerAddedTvList extends StatefulWidget {
  const CustomerAddedTvList({super.key});

  @override
  State<CustomerAddedTvList> createState() => _CustomerAddedTvListState();
}

class _CustomerAddedTvListState extends State<CustomerAddedTvList> {
  final tvList = [
    'https://static.vecteezy.com/system/resources/thumbnails/001/558/661/small/realistic-flat-tv-screen-vector.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYIzSohHeL_WwOIx7U-wG4NX1D8Ma_3Wi75g&usqp=CAU',
    'https://static.vecteezy.com/system/resources/thumbnails/001/558/661/small/realistic-flat-tv-screen-vector.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text('Your tv'),
          centerTitle: true,
        ),
        Expanded(
          child: SizedBox(
            height: 250,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: tvList.length,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserAddedTvDetailsScreen(
                              image: tvList[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 150,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.grey.shade200)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                tvList[index],
                                fit: BoxFit.fill,
                                height: 100,
                              ),
                            ),

                            SizedBox(width: 20,),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Model name',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Text(
                                    '₹100000',
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CustomButton(
            text: 'Add your tv',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomerAddUsedTV(),
                  ));
            },
          ),
        )
      ],
    );
  }
}
