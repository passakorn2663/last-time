import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lasttime/boxes.dart';
import 'package:lasttime/model/last_time.dart';
import 'package:lasttime/page/last_time_page.dart';
import 'package:lasttime/widget/new_last_time.dart';
import 'package:outline_search_bar/outline_search_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(LastTimeAdapter());

  await Hive.openBox<LastTime>('last_time');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Last Time',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LastTimePage());
  }
}
