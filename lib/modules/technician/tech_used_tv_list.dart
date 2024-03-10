import 'package:flutter/material.dart';
import 'package:tv_service/modules/technician/tech_usedtv_details.dart';
import 'package:tv_service/widgets/custom_button.dart';

class TechUsedTvListScreen extends StatefulWidget {
  const TechUsedTvListScreen({super.key});

  @override
  State<TechUsedTvListScreen> createState() => _TechUsedTvListScreenState();
}

class _TechUsedTvListScreenState extends State<TechUsedTvListScreen> {
  final _usedtvlist = [
    'https://static.vecteezy.com/system/resources/thumbnails/001/558/661/small/realistic-flat-tv-screen-vector.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYIzSohHeL_WwOIx7U-wG4NX1D8Ma_3Wi75g&usqp=CAU',
    'https://static.vecteezy.com/system/resources/thumbnails/001/558/661/small/realistic-flat-tv-screen-vector.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Used Tv'),
        centerTitle: true,
      ),
     
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  childAspectRatio: .5,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 10,
                  children: List.generate(
                    _usedtvlist.length,
                    (index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TechUsedTvDetailsScreen(
                              image: _usedtvlist[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 150,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.grey.shade200)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                _usedtvlist[index],
                                fit: BoxFit.fill,
                                height: 120,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Name',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Name',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: CustomButton(
                                      text: 'view more',
                                      color: Colors.amber,
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
