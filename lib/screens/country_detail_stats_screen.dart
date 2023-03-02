import 'package:covid_tracker_app/constants/colors.dart';
import 'package:covid_tracker_app/widgets/reusable_row.dart';
import 'package:flutter/material.dart';

class CountryDetailStatsScreen extends StatefulWidget {
  //**
  final String name, image;
  final int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      testPerOneMillion,
      test;

  const CountryDetailStatsScreen({
    Key? key,
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
    required this.testPerOneMillion,
  }) : super(key: key);

  @override
  State<CountryDetailStatsScreen> createState() =>
      _CountryDetailStatsScreenState();
}

class _CountryDetailStatsScreenState extends State<CountryDetailStatsScreen> {
  @override
  Widget build(BuildContext context) {
    //** media query ->
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //** appBar ->
      appBar: AppBar(
        title: Text(
          widget.name,
          style: const TextStyle(
            fontFamily: 'poppins_bold',
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        elevation: 5.0,
        backgroundColor: appBarColor,
      ),

      //** body ->
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.067),
                    child: Card(
                      color: const Color.fromRGBO(26, 29, 26, 1),
                      child: Column(
                        children: [
                          SizedBox(height: size.height * 0.06),
                          ReusableRow(
                            title: 'Total  Cases',
                            value: widget.totalCases.toString(),
                          ),
                          ReusableRow(
                            title: 'Total  Deaths',
                            value: widget.totalDeaths.toString(),
                          ),
                          ReusableRow(
                            title: 'Total  Recovered',
                            value: widget.totalRecovered.toString(),
                          ),
                          ReusableRow(
                            title: 'Critical',
                            value: widget.critical.toString(),
                          ),
                          ReusableRow(
                            title: 'Active',
                            value: widget.active.toString(),
                          ),
                          ReusableRow(
                            title: 'Test',
                            value: widget.test.toString(),
                          ),
                          ReusableRow(
                            title: 'TestPerOneMillion',
                            value: widget.testPerOneMillion.toString(),
                          ),
                          ReusableRow(
                            title: 'Today  Recovered',
                            value: widget.todayRecovered.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(widget.image),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
