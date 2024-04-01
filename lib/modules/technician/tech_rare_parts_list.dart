import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tv_service/services/api_servicces.dart';
import 'package:tv_service/widgets/custom_button.dart';

class TechRarePartsScreens extends StatefulWidget {
  const TechRarePartsScreens({Key? key}) : super(key: key);

  @override
  _TechRarePartsScreensState createState() => _TechRarePartsScreensState();
}

class _TechRarePartsScreensState extends State<TechRarePartsScreens> {
  late Future<List<dynamic>> _futureRareParts;

  @override
  void initState() {
    super.initState();
    _futureRareParts = fetchRareParts();
  }

  Future<List<dynamic>> fetchRareParts() async {
    print('hi');
    final response =
        await http.get(Uri.parse('${ApiServices.baseUrl}/api/user/view-spareparts'));

        print(response.body);






    if (response.statusCode == 201) {

      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to fetch rare parts');
    }
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
              "PARTS",
              style: TextStyle(fontSize: 25),
            ),
            Icon(Icons.tv_sharp)
          ],
        ),
        toolbarHeight: 100,
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomButton(
          text: 'Add Rare parts',
          onPressed: () {
            // Navigate to add rare parts screen
          },
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _futureRareParts,
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
            List<dynamic> rareParts = snapshot.data!;
            return ListView.builder(
              itemCount: rareParts.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 150,
                  child: Card(
                    color: Colors.white,
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                rareParts[index]['image'],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                           Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.settings_suggest),
                                    Text(rareParts[index]['part_name'])
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.book),
                                    Text(rareParts[index]['model'])
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.price_change),
                                    Text(rareParts[index]['price'].toString())
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
