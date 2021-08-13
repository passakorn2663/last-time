import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lasttime/model/last_time.dart';
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
      home: MyHomePage(title: 'Last Time'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 200,
                  child: DropdownSearch<String>(
                    maxHeight: 150,
                    mode: Mode.MENU,
                    items: ["งานบ้าน", "งานบ้าน", "งานบ้าน"],
                  ),
                )
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  'Jobs',
                ),
                // ListView.builder(
                //     itemCount: 5,
                //     itemBuilder: (context, index) {
                //       return Container(
                //           height: 50,
                //           width: 50,
                //           child: Card(child: Text('จ๊ะเอ๋')));
                //     })
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add your last time',
        child: Icon(Icons.add),
        onPressed: () {
          _createLastTime(context);
        },
      ),
    );
  }

  _createLastTime(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: NewLastTime(),
          );
        });
  }
}
