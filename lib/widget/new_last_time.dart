import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewLastTime extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewLastTime();
  }
}

class _NewLastTime extends State<NewLastTime> {
  
  final titleController = TextEditingController();
  final categoryController = TextEditingController();

  DateTime lastTime = DateTime.now();
  _NewLastTime();


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 50,
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: [
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
            initialValue: '',
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.person),
                hintText: 'Enter your job',
                labelText: 'Job'),
          validator: (title) =,
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
