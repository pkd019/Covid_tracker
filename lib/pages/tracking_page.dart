import 'package:covid_tracker/Services/services.dart';
import 'package:covid_tracker/pages/fulldata.dart';
import 'package:flutter/material.dart';

class trackingPage extends StatefulWidget {
  const trackingPage({Key? key}) : super(key: key);

  @override
  State<trackingPage> createState() => _trackingPageState();
}

class _trackingPageState extends State<trackingPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Service service = Service();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade900,
                  filled: true,
                  hintText: "enter country name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  suffixIcon: searchController.text.isEmpty
                      ? const Icon(Icons.search)
                      : GestureDetector(
                          onTap: () {
                            searchController.text = "";
                            setState(() {});
                          },
                          child: Icon(Icons.clear)),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Expanded(
                child: FutureBuilder(
              future: service.fetchcountry(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Center(child: CircularProgressIndicator());
                    },
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
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
                                          builder: (context) => fulldata(
                                                image: snapshot.data![index]
                                                    ['countryInfo']['flag'],
                                                name: snapshot.data![index]
                                                    ['country'],
                                                totalCases: snapshot
                                                    .data![index]['cases'],
                                                totalRecovered: snapshot
                                                    .data![index]['recovered'],
                                                totalDeaths: snapshot
                                                    .data![index]['deaths'],
                                                active: snapshot.data![index]
                                                    ['active'],
                                                test: snapshot.data![index]
                                                    ['tests'],
                                                todayRecovered:
                                                    snapshot.data![index]
                                                        ['todayRecovered'],
                                                critical: snapshot.data![index]
                                                    ['critical'],
                                              )));
                                },
                                child: ListTile(
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag']),
                                  ),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text("Effected: " +
                                      snapshot.data![index]['cases']
                                          .toString()),
                                ),
                              ),
                              Divider()
                            ],
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => fulldata(
                                                image: snapshot.data![index]
                                                    ['countryInfo']['flag'],
                                                name: snapshot.data![index]
                                                    ['country'],
                                                totalCases: snapshot
                                                    .data![index]['cases'],
                                                totalRecovered: snapshot
                                                    .data![index]['recovered'],
                                                totalDeaths: snapshot
                                                    .data![index]['deaths'],
                                                active: snapshot.data![index]
                                                    ['active'],
                                                test: snapshot.data![index]
                                                    ['tests'],
                                                todayRecovered:
                                                    snapshot.data![index]
                                                        ['todayRecovered'],
                                                critical: snapshot.data![index]
                                                    ['critical'],
                                              )));
                                },
                                child: ListTile(
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag']),
                                  ),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text("Effected: " +
                                      snapshot.data![index]['cases']
                                          .toString()),
                                ),
                              ),
                              Divider()
                            ],
                          );
                        } else {
                          return Container();
                        }
                      });
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
