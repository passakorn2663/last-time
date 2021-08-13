import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewLastTime extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewLastTime();
  }
}

class _NewLastTime extends State<NewLastTime> {
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
              Text('Last Time'),
              FloatingActionButton(
                mini: true,
                child: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            initialValue: '',
          )
        ],
      ),
    );
  }
}
