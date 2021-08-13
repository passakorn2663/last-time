import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lasttime/boxes.dart';
import 'package:lasttime/model/last_time.dart';

class LastTimePage extends StatefulWidget {
  @override
  _LastTimePageState createState() => _LastTimePageState();
}

class _LastTimePageState extends State<LastTimePage> {
  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Last Time'),
        centerTitle: true,
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
                ValueListenableBuilder<Box<LastTime>>(
                    valueListenable: Boxes.getLastTime().listenable(),
                    builder: (context, box, _) {
                      return Text('helo');
                    }),
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

  Future addTransaction(
      String title, String category, DateTime lastTime) async {
    final transaction = LastTime()
      ..title = title
      ..category = category
      ..lastTime = DateTime.now();

    final box = Boxes.getLastTime();
    box.add(transaction);
    //box.put('mykey', transaction);

    // final mybox = Boxes.getTransactions();
    // final myTransaction = mybox.get('key');
    // mybox.values;
    // mybox.keys;
  }
}
