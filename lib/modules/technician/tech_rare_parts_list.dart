import 'package:flutter/material.dart';
import 'package:tv_service/modules/technician/tech_rare_parts_screen.dart';
import 'package:tv_service/widgets/custom_button.dart';

class TechRarePartsScreens extends StatefulWidget {
  const TechRarePartsScreens({super.key});

  @override
  State<TechRarePartsScreens> createState() => _TechRarePartsScreensState();
}

class _TechRarePartsScreensState extends State<TechRarePartsScreens> {
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TechyAddRareParts(),
              ),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA04Xi65T41ir_qTRvwgYw8Q43QLaMcjzWNA&s',
                      fit: BoxFit.fitHeight,
                    ),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                       
                        
                        Row(
                          children: [
                            Icon(Icons.settings_suggest),
                            Text('capcitor')
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),


                         Row(
                          children: [
                            Icon(Icons.phone),
                            Text('3456789')
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        
                        Row(
                          children: [
                            Icon(Icons.location_on),
                            Text('abc street')
                          ],
                        ),
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
}
