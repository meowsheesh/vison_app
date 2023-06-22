import 'package:hive/hive.dart';

part 'history.g.dart';

@HiveType(typeId: 2)
class History extends HiveObject {
  @HiveField(0)
  final String photoPath;
  @HiveField(1)
  final String text;

  History(this.photoPath, this.text);
}