import 'package:flutter/material.dart';

class ProfileInputArea extends StatelessWidget {
  ProfileInputArea({
    Key key,
    @required this.onSave,
  }) : super(key: key);

  final Null Function(String profilename) onSave;
  final profileNameTextEditingController = TextEditingController();

  saveData(context) {
    String profileName = profileNameTextEditingController.text;
    if (profileName.isEmpty) return;
    onSave(profileName);
    profileNameTextEditingController.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: MediaQuery.of(context).viewInsets,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Enter Profile Name'),
              TextField(
                autofocus: true,
                controller: profileNameTextEditingController,
                cursorColor: Colors.redAccent,
                decoration: InputDecoration(
                  labelText: 'Profile Name',
                ),
                onSubmitted: (_) => saveData(context),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => saveData(context),
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
