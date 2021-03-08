import 'package:flutter/material.dart';

class DebtDashboard extends StatelessWidget {
  const DebtDashboard({
    Key key,
    @required this.profileName,
  }) : super(key: key);

  final profileName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$profileName Transactions'),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
