// main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'personal_info_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Apps.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PersonalInfoProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeActivity(),
      theme: ThemeData(
        primaryColor: Colors.black87,
        hintColor: Colors.black87,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            color: Colors.black87,
          ),
          titleSmall: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}

class HomeActivity extends StatelessWidget {
  const HomeActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Weather App",
            style: Theme.of(context).textTheme.titleLarge!,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                icon:
                    Icon(Icons.apps_outage_outlined, color: Colors.tealAccent),
                text: 'Apps',
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.black54,
            child: ListView(
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Apps(),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }
}
