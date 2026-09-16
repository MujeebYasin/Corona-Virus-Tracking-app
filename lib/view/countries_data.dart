import 'package:corona_virus/Modal/services/fetching_api.dart';
import 'package:corona_virus/view/single_country.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class countriesData extends StatefulWidget {
  const countriesData({super.key});

  @override
  State<countriesData> createState() => _countriesDataState();
}

class _countriesDataState extends State<countriesData> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    countries Countries = countries();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'search with country name',
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<dynamic>(
              future: Countries.fetchData(),
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[700]!,
                        highlightColor: Colors.grey[100]!,
                        child: Column(
                          children: [
                            ListTile(
                              title: Container(
                                height: 10,
                                width: 90,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 20,
                                width: 90,
                                color: Colors.grey,
                              ),
                              leading: Container(
                                height: 50,
                                width: 50,
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
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];
                      if (searchController.text.isEmpty) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      name: snapshot.data![index]['country'],
                                      image: snapshot
                                          .data![index]['countryInfo']['flag'],
                                      totalcases:
                                          snapshot.data![index]['cases'],
                                      totalDeaths:
                                          snapshot.data![index]['deaths'],
                                      totalRecoverd:
                                          snapshot.data![index]['recovered'],
                                      active: snapshot.data![index]['active'],
                                      critical:
                                          snapshot.data![index]['critical'],
                                      test: snapshot.data![index]['tests'],
                                      todayRecovered: snapshot
                                          .data![index]['todayRecovered'],
                                      todayDeaths:
                                          snapshot.data![index]['todayDeaths'],
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                  snapshot.data![index]['cases'].toString(),
                                ),
                                leading: Image(
                                  image: NetworkImage(
                                    snapshot
                                        .data![index]['countryInfo']['flag'],
                                  ),
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (name.toLowerCase().contains(
                        searchController.text.toLowerCase(),
                      )) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      name: snapshot.data![index]['country'],
                                      image: snapshot
                                          .data![index]['countryInfo']['flag'],
                                      totalcases:
                                          snapshot.data![index]['cases'],
                                      totalDeaths:
                                          snapshot.data![index]['deaths'],
                                      totalRecoverd:
                                          snapshot.data![index]['recovered'],
                                      active: snapshot.data![index]['active'],
                                      critical:
                                          snapshot.data![index]['critical'],
                                      test: snapshot.data![index]['tests'],
                                      todayRecovered:
                                          snapshot.data![index]['recovered'],
                                      todayDeaths:
                                          snapshot.data![index]['todayDeaths'],
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                  snapshot.data![index]['cases'].toString(),
                                ),
                                leading: Image(
                                  image: NetworkImage(
                                    snapshot
                                        .data![index]['countryInfo']['flag'],
                                  ),
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
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
    );
  }
}
