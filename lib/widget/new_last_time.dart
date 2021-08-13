import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lasttime/boxes.dart';
import 'package:lasttime/model/last_time.dart';

class NewLastTime extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewLastTime();
  }
}

class _NewLastTime extends State<NewLastTime> {
  final formKey = GlobalKey<FormState>();
  final LastTime newLastTime =
      LastTime(category: 'Work', lastTime: DateTime.now());

  DateTime lastTime = DateTime.now();
  final List<String> selectcCategoryList = ['Work', 'Play', 'Other'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Last Time'),
      content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              SizedBox(
                height: 5,
              ),
              buildTitle(),
              SizedBox(
                height: 5,
              ),
              buildCategory()
            ]),
          )),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context),
      ],
    );
  }

  Widget buildTitle() => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter tiltle',
        ),
        onChanged: (value) {
          newLastTime.title = value;
          newLastTime.lastTime = DateTime.now();
        },
      );

  Widget buildCategory() => DropdownButton<String>(
        value: newLastTime.category,
        style: const TextStyle(color: Colors.blue),
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            newLastTime.category = newValue!;
          });
        },
        items:
            selectcCategoryList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );

  // Widget buildCategory2() => DropdownSearch<String>(
  //       maxHeight: 150,
  //       mode: Mode.MENU,
  //       onSaved: (String? newValue) {
  //         newLastTime.category = newValue!;
  //       } ,
  //       it
  //       value: newLastTime.category,
  //       style: const TextStyle(color: Colors.deepPurple),
  //       isExpanded: true,

  //       items: <String>['งานบ้าน', 'งาน1']
  //           .map<DropdownMenuItem<String>>((String value) {
  //         return DropdownMenuItem<String>(
  //           value: value,
  //           child: Text(value),
  //         );
  //       }).toList(),
  //     );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context) {
    return TextButton(
        child: Text('Add'),
        onPressed: () {
          Boxes.getLastTime().add(newLastTime);
          Navigator.of(context).pop();
        });
  }
}
