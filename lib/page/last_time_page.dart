import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lasttime/boxes.dart';
import 'package:lasttime/model/last_time.dart';
import 'package:lasttime/widget/new_last_time.dart';
import 'package:intl/intl.dart';

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
                    items: ["งานบ้าน", "งาน2", "งาน3"],
                  ),
                )
              ],
            ),
            Column(
              children: <Widget>[
                ValueListenableBuilder<Box<LastTime>>(
                    valueListenable: Boxes.getLastTime().listenable(),
                    builder: (context, box, _) {
                      final lasttimes = box.values.toList().cast<LastTime>();

                      return buildContent(lasttimes);
                    }),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => NewLastTime(
            onClickedDone: addLastTime,
          ),
        ),
      ),
    );
  }

  Widget buildContent(List<LastTime> lasttimes) {
    if (lasttimes.isEmpty) {
      return Center(
        child: Text(
          'No Jobs yet!',
          style: TextStyle(fontSize: 24),
        ),
      );
    }
    return Column(
      children: [
        Text('hello'),
        SizedBox(height: 5),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(5),
            itemCount: lasttimes.length,
            itemBuilder: (BuildContext context, int index) {
              final lasttime = lasttimes[index];

              return buildLastTime(context, lasttime);
            },
          ),
        ),
      ],
    );
  }
}

Widget buildLastTime(
  BuildContext context,
  LastTime lastTime,
) {
  final date = DateFormat.yMMMd().format(lastTime.lastTime);

  return Container(
    height: 50,
    width: 100,
    child: Card(
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          lastTime.title,
          maxLines: 2,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(date),
        trailing: Text(
          lastTime.category,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    ),
  );
}

Future addLastTime(String title, /*String category,*/ DateTime lastTime) async {
  final lasttime = LastTime()
    ..title = title
    // ..category = category
    ..lastTime = DateTime.now();

  final box = Boxes.getLastTime();
  box.add(lasttime);
}
