import 'package:corona_virus/view/Home_Page.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name, image;
  int totalcases,
      totalDeaths,
      totalRecoverd,
      active,
      critical,
      test,
      todayRecovered,
      todayDeaths;

  DetailScreen({
    Key? key,
    required this.name,
    required this.image,
    required this.totalcases,
    required this.totalDeaths,
    required this.totalRecoverd,
    required this.active,
    required this.critical,
    required this.test,
    required this.todayRecovered,
    required this.todayDeaths,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Card(
                    margin: const EdgeInsets.only(top: 40),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Reuseable(
                          title: 'Total',
                          value: widget.totalcases.toString(),
                        ),
                        Reuseable(
                          title: 'Recovered',
                          value: widget.totalRecoverd.toString(),
                        ),
                        Reuseable(
                          title: 'Death',
                          value: widget.totalDeaths.toString(),
                        ),
                        Reuseable(
                          title: 'Active',
                          value: widget.active.toString(),
                        ),
                        Reuseable(
                          title: 'Critical',
                          value: widget.critical.toString(),
                        ),
                        Reuseable(
                          title: 'Today Cases',
                          value: widget.test.toString(),
                        ),
                        Reuseable(
                          title: 'Today Recoverd',
                          value: widget.todayRecovered.toString(),
                        ),
                        Reuseable(
                          title: 'Today Death',
                          value: widget.todayDeaths.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
