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
  List<String> categoryList = ["Any", "งาน1", "งาน2"];
  List<String> sortList = ["Newest", "Oldest"];

  String? currentCategory = "Any";
  String? currentSort;

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
                  width: 100,
                  child: DropdownButton<String>(
                    value: currentCategory,
                    style: const TextStyle(color: Colors.blue),
                    onChanged: (String? value) {
                      setState(() {
                        currentCategory = value!;
                      });
                    },
                    items: categoryList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  width: 100,
                  child: DropdownButton<String>(
                    value: currentSort,
                    style: const TextStyle(color: Colors.blue),
                    onChanged: (String? value) {
                      setState(() {
                        currentSort = value!;
                      });
                    },
                    items:
                        sortList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ValueListenableBuilder<Box<LastTime>>(
                    valueListenable: Boxes.getLastTime().listenable(),
                    builder: (context, box, _) {
                      final lasttimes = box.values.toList().cast<LastTime>();
                      sortingByDropDown(lasttimes);
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
          builder: (context) => NewLastTime(),
        ),
      ),
    );
  }

  Widget buildContent(List<LastTime> lasttimes) {
    return Visibility(
        visible: lasttimes.isEmpty,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Nothing in this category yet!',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Center(
              child: Text(
                'Go add something!',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
        replacement: ReorderableListView.builder(
            shrinkWrap: true,
            itemCount: lasttimes.length,
            itemBuilder: (context, index) {
              final lastTime = lasttimes[index];
              return buildLastTime(context, lastTime);
            },
            onReorder: (int start, int current) async {
              List<LastTime> _list = List.from(lasttimes);

              if (start < current) {
                int end = current - 1;
                LastTime startItem = _list[start];
                int i = 0;
                int local = start;
                do {
                  _list[local] = _list[++local];
                  i++;
                } while (i < end - start);
                _list[end] = startItem;
              } else if (start > current) {
                LastTime startItem = _list[start];
                for (int i = start; i > current; i--) {
                  _list[i] = _list[i - 1];
                }
                _list[current] = startItem;
              }
            }));
  }

  void sortingByDropDown(List<LastTime> lastTimeList) {
    print(currentSort);
    print(currentCategory);

    if (currentCategory != null && currentCategory != 'None') {
      lastTimeList.removeWhere((last) => last.category != currentCategory);
    }
    if (currentSort == sortList[0]) {
      lastTimeList.sort((a, b) => b.lastTime.compareTo(a.lastTime));
    } else if (currentSort == sortList[1]) {
      lastTimeList.sort((a, b) => a.lastTime.compareTo(b.lastTime));
    }
  }
}

Widget buildLastTime(
  BuildContext context,
  LastTime lastTime,
) {
  final date = DateFormat.yMMMd().format(lastTime.lastTime);

  return Container(
    key: ValueKey(lastTime),
    // height: 150,
    // width: 100,
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
