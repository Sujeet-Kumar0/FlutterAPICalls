import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:paprclip/API/getDataFromAPI.dart';
import 'package:paprclip/models/overviewAPIresponce.dart';

import 'models/technicalPerformanceAPIresponce.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final uri1 =
      "https://api.stockedge.com/Api/SecurityDashboardApi/GetCompanyEquityInfoForSecurity/5051?lang=en";
  final uri2 =
      "https://api.stockedge.com/Api/SecurityDashboardApi/GetTechnicalPerformanceBenchmarkForSecurity/5051?lang=en";

  late Future<OverviewResponce> OverViewAPIResponce;
  late Future<TechnicalOverviewResponce> TechnicalOverviewAPIResponce;

  @override
  void initState() {
    super.initState();
    OverViewAPIResponce =
        OverviewResponce.fromJson(fetchAlbum(uri1) as Map<String, dynamic>)
            as Future<OverviewResponce>;
    TechnicalOverviewAPIResponce = TechnicalOverviewResponce.fromJson(
            fetchAlbum(uri2) as Map<String, dynamic>)
        as Future<TechnicalOverviewResponce>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
                future: OverViewAPIResponce,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("Sector" + snapshot!.data.Sector),
                      );
                    });
                  } else if (snapshot.hasError) {
                    return Text("Error");
                  }
                  return CircularProgressIndicator();
                })
          ],
        ),
      ),
    );
  }
}
