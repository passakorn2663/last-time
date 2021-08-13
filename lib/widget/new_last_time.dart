import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lasttime/model/last_time.dart';

class NewLastTime extends StatefulWidget {
  final LastTime? lastTime;
  final Function(String name) onClickedDone;

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
  final formKey = GlobalKey<FormState>();
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
            ]),
          )),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context),
      ],
    );
  }

  Widget buildTitle() => TextFormField(
        controller: titleController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter job',
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'Enter job' : null,
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context) {
    return TextButton(
      child: Text('Add'),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final title = titleController.text;
          widget.onClickedDone(title);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
