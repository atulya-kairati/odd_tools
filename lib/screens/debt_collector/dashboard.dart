import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:odd_tools/models/debt_profile.dart';
import 'package:odd_tools/screens/debt_collector/editor.dart';
import 'package:intl/intl.dart';

// if the sum of transactions is -63 then
// you should read it as "you have taken 63"

class DebtDashboard extends StatelessWidget {
  const DebtDashboard({
    Key key,
    @required this.profileIndex,
  }) : super(key: key);

  final int profileIndex;
  static const classname = 'DebtDashboard';

  int get transactionSum {
    final profile = Hive.box('debts').getAt(profileIndex) as DebtProfile;
    int sum = 0;
    for (Transaction transaction in profile.transactions) {
      sum += transaction.amount;
    }
    return sum;
  }

  void deleteTransaction(int transactionIndex) {
    log("deletion index: $transactionIndex");
    var requiredProfile = Hive.box('debts').getAt(profileIndex) as DebtProfile;
    var savedTransactionList = [...requiredProfile.transactions];
    savedTransactionList.removeAt(transactionIndex);
    print(savedTransactionList);
    requiredProfile.transactions = savedTransactionList;
    requiredProfile.save();
  }

  @override
  Widget build(BuildContext context) {
    const functionName = 'build';
    log('$functionName in ${DebtDashboard.classname} called');
    var total = transactionSum;
    print(total);
    var debtProfiles = Hive.box('debts');
    var requiredProfile = debtProfiles.getAt(profileIndex) as DebtProfile;
    return Scaffold(
      appBar: AppBar(
        title: Text('${requiredProfile.name} Transactions'),
        backgroundColor: Colors.redAccent,
      ),
      body: ValueListenableBuilder(
        valueListenable: debtProfiles.listenable(),
        builder: (BuildContext _, Box __, Widget ___) {
          print(
              "ValueListenableBuilder in $functionName in $classname triggered");
          total = transactionSum;
          return Column(
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  child: ListView.builder(
                    itemCount: requiredProfile.transactions.length,
                    itemBuilder: (_, transactionIndex) {
                      Transaction transaction;
                      try {
                        transaction = requiredProfile.transactions
                            .elementAt(transactionIndex);
                      } catch (RangaError) {
                        log('$RangeError => index: $transactionIndex');
                        return SizedBox();
                      }
                      return ListTile(
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              transaction.amount >= 0 ? "Given" : "Taken",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: transaction.amount >= 0
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              transaction.amount.abs().toString(),
                              style: TextStyle(
                                fontFamily: "Quicksand",
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${transaction.purpose}',
                              style: TextStyle(
                                fontFamily: "Quicksand",
                              ),
                            ),
                            Text(
                              'On ${DateFormat.yMMMd().format(transaction.dateTime)} at ${DateFormat.Hm().format(transaction.dateTime)}',
                              style: TextStyle(
                                fontFamily: "Quicksand",
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                deleteTransaction(transactionIndex);
                              },
                              icon: Icon(Icons.delete),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => TransactionEditor(
                                      profileIndex: profileIndex,
                                      transactionIndex: transactionIndex,
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(Icons.edit),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: FittedBox(
                          child: Text(
                            (total >= 0)
                                ? "${requiredProfile.name} owes you $total"
                                : "You owe ${requiredProfile.name} ${total.abs()}",
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => TransactionEditor(
                                    profileIndex: profileIndex)),
                          );

                          // requiredProfile.transactions = [
                          //   ...requiredProfile.transactions,
                          //   Transaction(
                          //       amount: -4,
                          //       purpose: 'test',
                          //       dateTime: DateTime.now())
                          // ];
                          // requiredProfile.save();
                        },
                        child: Text('Add New Transaction'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
