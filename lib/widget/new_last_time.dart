import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lasttime/model/last_time.dart';

class NewLastTime extends StatefulWidget {
  final LastTime? lastTime;
  final Function(String title, String category, DateTime lasttime)
      onClickedDone;

  NewLastTime({
    Key? key,
    this.lastTime,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NewLastTime();
  }
}

class _NewLastTime extends State<NewLastTime> {
  final titleController = TextEditingController();
  final categoryController = TextEditingController();

  DateTime lastTime = DateTime.now();

  @override
  void initState() {
    super.initState();

    if (widget.lastTime != null) {
      final transaction = widget.lastTime!;

      titleController.text = transaction.title;
      categoryController.text = transaction.category.toString();
      lastTime = transaction.lastTime;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    categoryController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: 50,
        padding: EdgeInsets.all(5.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Add Last Time'),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.person),
                hintText: 'Enter your job',
                labelText: 'Job'),
            validator: (title) =>
                title != null && title.isEmpty ? 'Enter Job' : null,
          ),
          SizedBox(
            height: 5,
          ),
          Text(''),
          SizedBox(
            height: 5,
          ),
        ]));
  }
}
