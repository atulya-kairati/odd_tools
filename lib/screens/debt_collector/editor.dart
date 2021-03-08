import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:odd_tools/models/debt_profile.dart';

class TransactionEditor extends StatelessWidget {
  static const classname = 'TransactionEditor';
  @override
  Widget build(BuildContext context) {
    const functionName = 'build';
    log('$classname in $functionName called');
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Transaction'),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              var requiredProfile = Hive.box('debts').getAt(1) as DebtProfile;

              requiredProfile.transactions = [
                ...requiredProfile.transactions,
                Transaction(
                    amount: -95, purpose: 'test', dateTime: DateTime.now())
              ];
              requiredProfile.save();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
