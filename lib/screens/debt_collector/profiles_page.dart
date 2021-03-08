import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:odd_tools/models/debt_profile.dart';
import 'package:odd_tools/widgets/profile_input_area.dart';

class ProfilePAge extends StatefulWidget {
  const ProfilePAge({Key key}) : super(key: key);
  static const mainColor = Colors.redAccent;
  static const classname = 'ProfilePage';

  @override
  _ProfilePAgeState createState() => _ProfilePAgeState();
}

class _ProfilePAgeState extends State<ProfilePAge> {
  saveProfile(String profileName) {
    Hive.box('debts').add(DebtProfile(
      profileName,
      <Transaction>[],
    ));
    log('Created Profile: $profileName');
  }

  @override
  Widget build(BuildContext context) {
    const functionName = 'build';
    log('$functionName in ${ProfilePAge.classname} called');

    return Scaffold(
      appBar: AppBar(
        title: Text('Debt Collector'),
        backgroundColor: ProfilePAge.mainColor,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: ProfilePAge.mainColor.shade400,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return ProfileInputArea(
                  onSave: (profileName) {
                    saveProfile(profileName);
                  },
                );
              });
          // Hive.box('debts').add(DebtProfile(
          //   'Pranshu Mottu',
          //   [Transaction('purpose', 2, DateTime.now())],
          // ));
        },
      ),
      body: FutureBuilder(
        future: Hive.openBox('debts'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return ProfileList();
          else if (snapshot.hasError) return Text(snapshot.error.toString());
          return Text('Intialising');
        },
      ),
    );
  }

  @override
  void dispose() {
    // Hive.box('debts').clear();
    Hive.box('debts').compact();
    Hive.box('debts').close();
    super.dispose();
  }
}

class ProfileList extends StatelessWidget {
  static const classname = 'ProfileList';
  @override
  Widget build(BuildContext context) {
    const functionName = 'build';
    log('$functionName in $classname called');
    final debtProfiles = Hive.box('debts');
    return ValueListenableBuilder(
      valueListenable: debtProfiles.listenable(),
      builder: (BuildContext context, Box debtProfilesBox, Widget child) {
        return ListView.builder(
          itemCount: debtProfilesBox.length,
          itemBuilder: (_, index) {
            final debtProfile = debtProfilesBox.getAt(index) as DebtProfile;
            return ListTile(
              onTap: () {},
              title: Text(debtProfile.name),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  debtProfilesBox.deleteAt(index);
                },
              ),
            );
          },
        );
      },
    );
  }
}
