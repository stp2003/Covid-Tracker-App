import 'package:covid_tracker_app/constants/colors.dart';
import 'package:covid_tracker_app/models/World_stats_model.dart';
import 'package:covid_tracker_app/screens/countries_lists.dart';
import 'package:covid_tracker_app/services/stats_services.dart';
import 'package:covid_tracker_app/widgets/reusable_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen>
    with TickerProviderStateMixin {
  //** defining animation controller and duration ->
  late final AnimationController animationController =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  //?? dispose ->
  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  //?? build ->
  @override
  Widget build(BuildContext context) {
    //** media query ->
    final size = MediaQuery.of(context).size;

    //** StatsServices ->
    StatsServices statsServices = StatsServices();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.01),
                FutureBuilder(
                  future: statsServices.fetchWorldStatsRecords(),
                  builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: animationController,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          //*** Pie-Chart ->
                          PieChart(
                            dataMap: {
                              'Total': double.parse(
                                snapshot.data!.cases!.toString(),
                              ),
                              'Recovered': double.parse(
                                snapshot.data!.recovered.toString(),
                              ),
                              'Deaths': double.parse(
                                snapshot.data!.deaths.toString(),
                              ),
                            },

                            //** for showing values in % ->
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            chartRadius: size.width / 2.3,
                            legendOptions: const LegendOptions(
                              legendShape: BoxShape.circle,
                            ),
                            animationDuration:
                                const Duration(milliseconds: 1500),
                            chartType: ChartType.ring,
                            colorList: const [
                              totalColor,
                              recoveredColor,
                              deathsColor
                            ],
                          ),

                          //**** card ->
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.06),
                            child: Card(
                              color: const Color.fromRGBO(26, 29, 26, 1),
                              child: Column(
                                children: [
                                  ReusableRow(
                                    title: 'Total  Cases',
                                    value: snapshot.data!.cases.toString(),
                                  ),
                                  ReusableRow(
                                    title: 'Today  Cases',
                                    value: snapshot.data!.todayCases.toString(),
                                  ),
                                  ReusableRow(
                                    title: 'Deaths',
                                    value: snapshot.data!.deaths.toString(),
                                  ),
                                  ReusableRow(
                                    title: 'Today  Deaths',
                                    value:
                                        snapshot.data!.todayDeaths.toString(),
                                  ),
                                  ReusableRow(
                                    title: 'Recovered',
                                    value: snapshot.data!.recovered.toString(),
                                  ),
                                  ReusableRow(
                                    title: 'Today  Recovered',
                                    value: snapshot.data!.todayRecovered
                                        .toString(),
                                  ),
                                  ReusableRow(
                                    title: 'Active  Cases',
                                    value: snapshot.data!.active.toString(),
                                  ),
                                  ReusableRow(
                                    title: 'Critical  Cases',
                                    value: snapshot.data!.critical.toString(),
                                  ),
                                  ReusableRow(
                                    title: 'Total  Recovered',
                                    value: snapshot.data!.todayRecovered
                                        .toString(),
                                  ),
                                  ReusableRow(
                                    title: 'Total  Tests',
                                    value: snapshot.data!.tests.toString(),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //*** for searching countries ->
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CountriesListScreen(),
                                ),
                              );
                            },
                            child: Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: recoveredColor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: const Center(
                                child: Text(
                                  'Track Countries',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'poppins_medium',
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12.0),
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
