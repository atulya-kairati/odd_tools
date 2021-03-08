import 'package:hive/hive.dart';
part 'debt_profile.g.dart';

@HiveType(typeId: 0)
class DebtProfile extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<Transaction> transactions;

  DebtProfile({this.name, this.transactions});
}

@HiveType(typeId: 1)
class Transaction extends HiveObject {
  @HiveField(0)
  String purpose;

  @HiveField(1)
  int amount;
  // if amount is positve => it was given and amount is -ve => it was taken

  @HiveField(2)
  DateTime dateTime;

  Transaction({this.purpose, this.amount, this.dateTime});
}
