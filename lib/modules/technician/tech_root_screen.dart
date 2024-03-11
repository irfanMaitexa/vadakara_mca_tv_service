import 'package:flutter/material.dart';
import 'package:tv_service/modules/technician/tech_complaint.dart';
import 'package:tv_service/modules/technician/tech_used_tv_list.dart';
import 'package:tv_service/widgets/custom_card.dart';

class home_technician extends StatelessWidget {
  const home_technician({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text(
          "TECHNICIAN",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Custom_Card(
            image: "assets/images/used tv.png",
            text: "USED TV'S",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TechUsedTvListScreen(),
                  ));
            },
          ),
          Custom_Card(
            image: "assets/images/complaint.png",
            text: "COMPLAINTS",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return TechComplaintScreen();
                  },
                ),
              );
            },
          ),
          Custom_Card(
            image: "assets/images/rare parts.png",
            text: "RARE PARTS",
          ),
        ]),
      ),
    );
  }
}
