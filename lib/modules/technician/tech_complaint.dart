import 'package:flutter/material.dart';
import 'package:tv_service/widgets/custom_button.dart';

class TechComplaintScreen extends StatefulWidget {
  @override
  _TechComplaintScreenState createState() => _TechComplaintScreenState();
}

class _TechComplaintScreenState extends State<TechComplaintScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Text('Pending'),
              ),
              Tab(
                icon: Text('Accepted'),
              ),
              Tab(
                icon: Text('Completed'),
              ),
            ],
          ),
          title: const Text('Complaints'),
        ),
        body: TabBarView(
          children: [
            //tab bar pending
            ListView.builder(
              itemBuilder: (context, index) => TvComplaintCard(
                onTab: () {
                  print(index.toString());
                },
                status: 'pending',
                buttonText: 'Accept',
              ),
            ),
            //tab bar accepted
            ListView.builder(
              itemBuilder: (context, index) => TvComplaintCard(
                onTab: () {
                  print(index.toString());
                },
                status: 'Accepted',
                buttonText: 'Complete',
              ),
            ),

            //tab bar Completed

            ListView.builder(
              itemBuilder: (context, index) => TvComplaintCard(
                onTab: () {
                  print(index.toString());
                },
                status: 'Completed',
                buttonText: 'Completed',
              ),
            )
            
          ],
        ),
      ),
    );
  }
}

class TvComplaintCard extends StatelessWidget {
  const TvComplaintCard(
      {super.key,
      required this.status,
      required this.buttonText,
      required this.onTab});

  final String status;
  final String buttonText;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrJ468ITU70SviByi71ALsK0XKruzALn6efA&usqp=CAU',
                    fit: BoxFit.fitHeight,
                  ),
                )),
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
                          Icon(Icons.settings_accessibility),
                          Text('Customer name')
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(Icons.settings_suggest),
                          Text('Tv repair')
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [Icon(Icons.pending), Text(status)],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if (status != 'Completed')
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CustomButton(
                  text: buttonText,
                  onPressed: onTab,
                ),
              )
          ],
        ),
      ),
    );
  }
}
