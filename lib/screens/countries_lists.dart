import 'package:covid_tracker_app/constants/colors.dart';
import 'package:covid_tracker_app/screens/country_detail_stats_screen.dart';
import 'package:covid_tracker_app/services/stats_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen>
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

  //** text editing controller ->
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //** stats services ->
    StatsServices statsServices = StatsServices();

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: bgColor,
      ),

      //*** body ->
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                style: const TextStyle(
                    fontFamily: 'poppins_medium', letterSpacing: 0.8),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  hintText: 'Search Countries name',
                  hintStyle: const TextStyle(
                      fontFamily: 'poppins', letterSpacing: 0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),

            //?? countries list ->
            Expanded(
              child: FutureBuilder(
                future: statsServices.fetchCountriesListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  //?? applying shimmer effect ->
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                  height: 10.0,
                                  width: 90.0,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10.0,
                                  width: 90.0,
                                  color: Colors.white,
                                ),
                                leading: Container(
                                  height: 50.0,
                                  width: 50.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        //** for search purposes ->
                        String name = snapshot.data![index]['country'];

                        //** if nothing searched then
                        //** return the entire list ->
                        if (searchController.text.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CountryDetailStatsScreen(
                                        name: snapshot.data![index]['country'],
                                        image: snapshot.data![index]
                                            ['countryInfo']['flag'],
                                        totalCases: snapshot.data![index]
                                            ['cases'],
                                        totalRecovered: snapshot.data![index]
                                            ['recovered'],
                                        totalDeaths: snapshot.data![index]
                                            ['deaths'],
                                        active: snapshot.data![index]['active'],
                                        test: snapshot.data![index]['tests'],
                                        todayRecovered: snapshot.data![index]
                                            ['todayRecovered'],
                                        critical: snapshot.data![index]
                                            ['critical'],
                                        testPerOneMillion: snapshot.data![index]
                                            ['testsPerOneMillion'],
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  //** title: country name ->
                                  title: Text(
                                    snapshot.data![index]['country'],
                                    style: const TextStyle(
                                      fontFamily: 'poppins_medium',
                                      letterSpacing: 0.8,
                                    ),
                                  ),

                                  //** subtitle: country cases ->
                                  subtitle: Text(
                                    snapshot.data![index]['cases'].toString(),
                                    style: const TextStyle(
                                      fontFamily: 'poppins',
                                      letterSpacing: 0.8,
                                    ),
                                  ),

                                  //** leading: country flag ->
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                      snapshot.data![index]['countryInfo']
                                          ['flag'],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        //** if searched and found
                        //** then return that country ->
                        else if (name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CountryDetailStatsScreen(
                                        name: snapshot.data![index]['country'],
                                        image: snapshot.data![index]
                                            ['countryInfo']['flag'],
                                        totalCases: snapshot.data![index]
                                            ['cases'],
                                        totalRecovered: snapshot.data![index]
                                            ['recovered'],
                                        totalDeaths: snapshot.data![index]
                                            ['deaths'],
                                        active: snapshot.data![index]['active'],
                                        test: snapshot.data![index]['tests'],
                                        todayRecovered: snapshot.data![index]
                                            ['todayRecovered'],
                                        critical: snapshot.data![index]
                                            ['critical'],
                                        testPerOneMillion: snapshot.data![index]
                                            ['testsPerOneMillion'],
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  //** title: country name ->
                                  title: Text(
                                    snapshot.data![index]['country'],
                                    style: const TextStyle(
                                      fontFamily: 'poppins_medium',
                                      letterSpacing: 0.8,
                                    ),
                                  ),

                                  //** subtitle: country cases ->
                                  subtitle: Text(
                                    snapshot.data![index]['cases'].toString(),
                                    style: const TextStyle(
                                      fontFamily: 'poppins',
                                      letterSpacing: 0.8,
                                    ),
                                  ),

                                  //** leading: country flag ->
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                      snapshot.data![index]['countryInfo']
                                          ['flag'],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        //** else nothing ->
                        else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
