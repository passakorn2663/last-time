import 'package:hive/hive.dart';
part 'last_time.g.dart';

@HiveType(typeId: 0)
class LastTime extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String category;
  @HiveField(2)
  DateTime lastTime;
  LastTime({this.title = '', required this.category, required this.lastTime});
}
