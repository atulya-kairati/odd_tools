import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:odd_tools/models/debt_profile.dart';

class TransactionEditor extends StatefulWidget {
  static const classname = 'TransactionEditor';
  final int profileIndex, transactionIndex;

  const TransactionEditor({
    Key key,
    @required this.profileIndex,
    this.transactionIndex,
  }) : super(key: key);

  @override
  _TransactionEditorState createState() => _TransactionEditorState();
}

class _TransactionEditorState extends State<TransactionEditor> {
  DateTime date = DateTime.now();
  TextEditingController amountTextEditingController = TextEditingController();
  TextEditingController purposeTextEditingController = TextEditingController();
  static const radioStateGiven = "given", radioStateTaken = "taken";
  String radioState = radioStateGiven;

  getDate() async {
    DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    print(pickedDate);
    setState(() {
      date = pickedDate;
    });
  }

  void addNewTransaction() {
    // given -> +
    // taken -> -
    int amount = int.tryParse(amountTextEditingController.text);
    String purpose = purposeTextEditingController.text;

    if (amount == null || purpose.isEmpty) return;

    if (radioState == radioStateTaken) amount *= -1;

    log('$amount, $purpose, $date');
    var requiredProfile =
        Hive.box('debts').getAt(widget.profileIndex) as DebtProfile;

    requiredProfile.transactions = [
      ...requiredProfile.transactions,
      Transaction(
        amount: amount,
        purpose: purpose,
        dateTime: date,
      )
    ];
    requiredProfile.save();

    Navigator.pop(context);
  }

  void initForTransactionEdit() {
    // called when saved transaction is to be edited
    print('transactionIndex: ${widget.transactionIndex}');
    Transaction requiredTransaction = Hive.box('debts')
        .getAt(widget.profileIndex)
        .transactions
        .elementAt(widget.transactionIndex);
    print(requiredTransaction.amount);
    amountTextEditingController.text =
        requiredTransaction.amount.abs().toString();

    purposeTextEditingController.text = requiredTransaction.purpose;

    radioState =
        requiredTransaction.amount >= 0 ? radioStateGiven : radioStateTaken;

    date = requiredTransaction.dateTime;
  }

  @override
  void initState() {
    super.initState();
    print('profileIndex: ${widget.profileIndex}');
    if (widget.transactionIndex != null) initForTransactionEdit();
  }

  @override
  Widget build(BuildContext context) {
    const functionName = 'build';
    log('${TransactionEditor.classname} in $functionName called');
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Transaction'),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: amountTextEditingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.text,
              controller: purposeTextEditingController,
              minLines: 2,
              maxLines: null,
              decoration: InputDecoration(
                labelText: "Purpose",
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.redAccent,
                )),
              ),
            ),
            SizedBox(height: 8),
            RadioListTile(
              title: Text('Given'),
              value: radioStateGiven,
              groupValue: radioState,
              onChanged: (value) {
                print(value);
                setState(() {
                  radioState = value;
                });
              },
            ),
            RadioListTile(
              title: Text('Taken'),
              value: radioStateTaken,
              groupValue: radioState,
              onChanged: (value) {
                print(value);
                setState(() {
                  radioState = value;
                });
              },
            ),
            SizedBox(height: 8),
            TextButton.icon(
              style: TextButton.styleFrom(
                primary: Colors.redAccent,
              ),
              onPressed: getDate,
              icon: Icon(Icons.calendar_today),
              label: Text(DateFormat.yMMMd().format(date)),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: addNewTransaction,
              child: Text('Save'),
              style: ElevatedButton.styleFrom(primary: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
