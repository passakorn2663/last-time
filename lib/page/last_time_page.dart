import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lasttime/boxes.dart';
import 'package:lasttime/model/last_time.dart';
import 'package:lasttime/widget/new_last_time.dart';
import 'package:intl/intl.dart';
import 'package:lasttime/widget/time_stamp.dart';

class LastTimePage extends StatefulWidget {
  @override
  _LastTimePageState createState() => _LastTimePageState();
}

class _LastTimePageState extends State<LastTimePage> {
  List<String> categoryList = ["Any", "Work", "Play", "Other"];
  List<String> sortList = ["Newest", "Oldest"];

  String? currentCategory;
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
                    hint: Text('Category'),
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
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: 100,
                  child: DropdownButton<String>(
                    hint: Text('Time'),
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
    if (currentCategory != null && currentCategory != 'Any') {
      lastTimeList.removeWhere((last) => last.category != currentCategory);
    }
    if (currentSort == sortList[0]) {
      lastTimeList.sort((a, b) => b.lastTime.last.compareTo(a.lastTime.last));
    } else if (currentSort == sortList[1]) {
      lastTimeList.sort((a, b) => a.lastTime.last.compareTo(b.lastTime.last));
    }
  }

  void _stampLastTime(LastTime lastTime) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Stamp time on this job?'),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  SizedBox(
                    width: 5,
                  ),
                  TextButton(
                      child: Text(
                        'Yes',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        lastTime.lastTime.last = DateTime.now();
                        lastTime.save();
                        Navigator.of(context).pop();
                      }),
                ],
              )
            ],
          );
        });
  }

  Widget buildLastTime(
    BuildContext context,
    LastTime lastTime,
  ) {
    final date = DateFormat.yMMMd().format(lastTime.lastTime.last);
    final time = DateFormat.Hm().format(lastTime.lastTime.last);
    return Container(
      height: 75,
      padding: EdgeInsets.all(5),
      key: ValueKey(lastTime),
      child: Card(
        color: Colors.white,
        child: ListTile(
          leading: _icon(lastTime),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    lastTime.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(lastTime.category, style: TextStyle(fontSize: 16))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(date),
                      Text(time),
                    ],
                  ),
                  Container(
                      child: ClipOval(
                    child: Material(
                      elevation: 5,
                      color: Colors.white, // Button color
                      child: InkWell(
                        onTap: () {
                          _stampLastTime(lastTime);
                        },
                        child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Icon(
                              Icons.beenhere_sharp,
                              color: Colors.blue,
                            )),
                      ),
                    ),
                  )),
                  Container(
                      child: ClipOval(
                    child: Material(
                      elevation: 5,
                      color: Colors.white, // Button color
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => TimeStamp(lastTime),
                          );
                        },
                        child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Icon(
                              Icons.history_edu,
                              color: Colors.blue,
                            )),
                      ),
                    ),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Icon _icon(LastTime lastime) {
  if (lastime.category == 'Work') {
    return Icon(
      Icons.work,
      color: Colors.blue,
    );
  } else if (lastime.category == 'Play')
    return Icon(
      Icons.sentiment_satisfied_rounded,
      color: Colors.blue,
    );
  else
    return Icon(
      Icons.settings_accessibility_sharp,
      color: Colors.blue,
    );
}
