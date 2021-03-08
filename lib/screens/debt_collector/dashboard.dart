import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:odd_tools/models/debt_profile.dart';
import 'package:odd_tools/screens/debt_collector/editor.dart';

class DebtDashboard extends StatelessWidget {
  const DebtDashboard({
    Key key,
    @required this.index,
  }) : super(key: key);

  final int index;
  static const classname = 'DebtDashboard';

  int get transactionSum {
    final profile = Hive.box('debts').getAt(index) as DebtProfile;
    int sum = 0;
    for (Transaction transaction in profile.transactions) {
      sum += transaction.amount;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    const functionName = 'build';
    log('$functionName in ${DebtDashboard.classname} called');
    var total = transactionSum;
    print(total);
    var debtProfiles = Hive.box('debts');
    var requiredProfile = debtProfiles.getAt(index) as DebtProfile;
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
                    itemBuilder: (_, index) {
                      final transaction =
                          requiredProfile.transactions.elementAt(index);
                      return ListTile(
                        title: Text(transaction.amount.abs().toString()),
                        subtitle: Text(transaction.purpose),
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
                                builder: (_) => TransactionEditor()),
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
