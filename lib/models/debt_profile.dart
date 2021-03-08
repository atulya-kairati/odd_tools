import 'package:hive/hive.dart';
part 'debt_profile.g.dart';

@HiveType(typeId: 0)
class DebtProfile {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<Transaction> transactions;

  DebtProfile(this.name, this.transactions);
}

@HiveType(typeId: 1)
class Transaction {
  @HiveField(0)
  final String purpose;

  @HiveField(1)
  final int amount;
  // if amount is positve => it was given and amount is -ve => it was taken

  @HiveField(2)
  final DateTime dateTime;

  Transaction(this.purpose, this.amount, this.dateTime);
}
