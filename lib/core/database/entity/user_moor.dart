import 'package:moor/moor.dart';

@DataClassName("dbUser")
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get username => text().withLength(min: 1, max: 50)();
}
