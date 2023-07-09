import 'package:covid_tracker/Services/services.dart';
import 'package:covid_tracker/model/WorldModel.dart';
import 'package:covid_tracker/pages/tracking_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/src/fading_circle.dart';
import 'package:pie_chart/pie_chart.dart';

class dashBoard extends StatefulWidget {
  const dashBoard({Key? key}) : super(key: key);

  @override
  State<dashBoard> createState() => _dashBoardState();
}

class _dashBoardState extends State<dashBoard> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Service service = Service();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  FutureBuilder(
                      future: service.fetchworldrecord(),
                      builder: (context, AsyncSnapshot<WorldModel> snapshot) {
                        if (!snapshot.hasData) {
                          return Expanded(
                              flex: 1,
                              child: SpinKitFadingCircle(
                                controller: _controller,
                                size: 50.0,
                                color: Colors.white,
                              ));
                        } else {
                          return Column(
                            children: [
                              PieChart(
                                chartLegendSpacing: 32,
                                dataMap: {
                                  "total": double.parse(
                                      snapshot.data!.cases!.toString()),
                                  "Recovered": double.parse(
                                      snapshot.data!.recovered.toString()),
                                  "Deaths": double.parse(
                                      snapshot.data!.deaths.toString()),
                                },
                                chartRadius:
                                    MediaQuery.of(context).size.width / 2.8,
                                animationDuration:
                                    const Duration(milliseconds: 1150),
                                chartType: ChartType.ring,
                                initialAngleInDegree: 0,
                                ringStrokeWidth: 25,
                                chartValuesOptions: const ChartValuesOptions(
                                    showChartValueBackground: true,
                                    showChartValues: true,
                                    showChartValuesInPercentage: true,
                                    showChartValuesOutside: true,
                                    decimalPlaces: 1),
                                legendOptions: const LegendOptions(
                                  legendPosition: LegendPosition.left,
                                  showLegends: true,
                                  legendTextStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  showLegendsInRow: false,
                                ),
                                colorList: [
                                  Colors.red.shade700,
                                  Colors.green.shade700,
                                  Colors.blue.shade700
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.04),
                                child: Card(
                                  color: Colors.deepOrangeAccent.shade200,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Total'),
                                            Text(
                                                snapshot.data!.cases.toString())
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Recovered'),
                                            Text(snapshot.data!.recovered
                                                .toString())
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Active'),
                                            Text(snapshot.data!.active
                                                .toString()),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Critical'),
                                            Text(snapshot.data!.critical
                                                .toString())
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Today Death'),
                                            Text(snapshot.data!.todayDeaths
                                                .toString())
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Today Recovered'),
                                            Text(snapshot.data!.todayRecovered
                                                .toString())
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      }),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const trackingPage()));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(25)),
                      child: const Center(child: Text('Track Countries')),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
