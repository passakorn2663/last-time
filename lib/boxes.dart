import 'package:hive/hive.dart';
import 'package:lasttime/model/last_time.dart';

class Boxes {
  static Box<LastTime> getLastTime() => Hive.box<LastTime>('last_time');
}
