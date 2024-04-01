import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tv_service/modules/customer/customer_add_tv.dart';
import 'package:tv_service/modules/customer/user_added_tv_details.dart';
import 'package:tv_service/services/api_servicces.dart';
import 'package:tv_service/widgets/custom_button.dart';

class CustomerAddedTvList extends StatefulWidget {
  const CustomerAddedTvList({Key? key});

  @override
  State<CustomerAddedTvList> createState() => _CustomerAddedTvListState();
}

class _CustomerAddedTvListState extends State<CustomerAddedTvList> {
  late Future<List<dynamic>> _tvListFuture;

  @override
  void initState() {
    super.initState();
    _tvListFuture = fetchTvList();
  }

  Future<List<dynamic>> fetchTvList() async {
    final response = await http.get(Uri.parse('${ApiServices.baseUrl}/api/user/view-user-used-tv'));
print(Uri.parse('${ApiServices.baseUrl}/api/user/view-user-used-tv'));
    if (response.statusCode == 201) {

      
      List<dynamic> data = json.decode(response.body)['data'];
      return data;
    } else {
      throw Exception('Failed to fetch TV list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text('Your TV'),
          centerTitle: true,
        ),
        Expanded(
          child: FutureBuilder<List<dynamic>>(
            future: _tvListFuture,
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
                List<dynamic> tvList = snapshot.data ?? [];
                return SizedBox(
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
                              image: tvList[index]['image'],
                              details :  tvList[index]
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
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                tvList[index]['image'],
                                fit: BoxFit.fill,
                                height: 100,
                              ),
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                            Text(
                              'Model: ${tvList[index]['model']}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'price:${tvList[index]['price']}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),Text(
                              'Type:${tvList[index]['type']}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CustomButton(
            text: 'Add Your TV',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomerAddUsedTV(),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
