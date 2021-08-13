import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lasttime/model/last_time.dart';

class TimeStamp extends StatefulWidget {
  late LastTime lastTime;
  TimeStamp(this.lastTime);
  @override
  State<StatefulWidget> createState() => _TimeStamp();
}

class _TimeStamp extends State<TimeStamp> {
  @override
  Widget build(BuildContext context) {
    var timeLength = widget.lastTime.lastTime.length;
    widget.lastTime.lastTime.sort((a, b) => b.compareTo(a));
    return Dialog(
      child: Container(
          width: 300,
          height: 300,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Center(
                  child: Text(
                    widget.lastTime.title + 'Timep Stamp',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: widget.lastTime.lastTime.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(5),
                        child: ListTile(
                          title: Text('#${index + 1}' +
                              ' ' +
                              '${DateFormat.yMMMd().add_Hm().format(widget.lastTime.lastTime[index])}'),
                        ),
                      );
                    }),
              ),
            ],
          )),
    );
  }
}
