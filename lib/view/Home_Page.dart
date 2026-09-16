import 'package:corona_virus/Modal/Api_Modal.dart';
import 'package:corona_virus/Modal/services/fetching_api.dart';
import 'package:corona_virus/view/countries_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 4),
    vsync: this,
  )..repeat();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final colorList = <Color>[Colors.blue, Colors.green, Colors.red];

  @override
  Widget build(BuildContext context) {
    services Services = services();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                  future: Services.fetchData(),
                  builder: (context, AsyncSnapshot<stateData> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: 300,
                        child: Center(
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50,
                            controller: _controller,
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return SizedBox(
                        height: 300,
                        child: Center(
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    } else if (!snapshot.hasData) {
                      return SizedBox(
                        height: 300,
                        child: Center(
                          child: Text(
                            'No data found',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(
                                snapshot.data!.cases!.toString(),
                              ),
                              "Recovered": double.parse(
                                snapshot.data!.recovered!.toString(),
                              ),
                              "Deaths": double.parse(
                                snapshot.data!.deaths!.toString(),
                              ),
                            },
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                            animationDuration: Duration(milliseconds: 1200),
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            chartType: ChartType.ring,
                            colorList: colorList,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .04,
                            ),
                            child: Card(
                              child: Column(
                                children: [
                                  Reuseable(
                                    title: 'Total',
                                    value: snapshot.data!.cases!.toString(),
                                  ),
                                  Reuseable(
                                    title: 'Recovered',
                                    value: snapshot.data!.recovered!.toString(),
                                  ),
                                  Reuseable(
                                    title: 'Death',
                                    value: snapshot.data!.deaths!.toString(),
                                  ),
                                  Reuseable(
                                    title: 'Active',
                                    value: snapshot.data!.active!.toString(),
                                  ),
                                  Reuseable(
                                    title: 'Critical',
                                    value: snapshot.data!.critical!.toString(),
                                  ),
                                  Reuseable(
                                    title: 'Today Cases',
                                    value: snapshot.data!.todayCases!
                                        .toString(),
                                  ),
                                  Reuseable(
                                    title: 'Today Recoverd',
                                    value: snapshot.data!.todayRecovered!
                                        .toString(),
                                  ),
                                  Reuseable(
                                    title: 'Today Death',
                                    value: snapshot.data!.todayDeaths!
                                        .toString(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => countriesData(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 70,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 4,
                                ),
                                child: Text('Track Countries'),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Reuseable extends StatelessWidget {
  String title, value;
  Reuseable({super.key, required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10),
              child: Text(title),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(value),
            ),
          ],
        ),
      ],
    );
  }
}
