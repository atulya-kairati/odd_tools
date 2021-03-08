import 'dart:developer';
import 'package:odd_tools/screens/debt_collector/profiles_page.dart';

import '../widgets/app_banner.dart';
import '../widgets/custom_Icon_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const classname = 'HomePage';
  @override
  Widget build(BuildContext context) {
    const functionName = 'build';
    log('$functionName in $classname called');
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Odd Tools'),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: AppBanner(),
          ),
          // Divider(),
          Expanded(
            flex: 6,
            child: Container(
              // color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 48),
              margin: EdgeInsets.only(top: 32),
              child: ListView(
                children: [
                  CustomIconButton(
                    color: Colors.redAccent,
                    icon: Icons.monetization_on,
                    label: 'Debt Collector',
                    onPressed: () {
                      log('Debt Collector');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePAge()),
                      );
                    },
                  ),
                  SizedBox(height: 12),
                  CustomIconButton(
                    color: Colors.deepPurpleAccent,
                    icon: Icons.copy,
                    label: 'ClipBoard Manager',
                    onPressed: () {
                      log('ClipBoard Manager');
                      log(DateTime.now().millisecondsSinceEpoch.toString());
                    },
                  ),
                  SizedBox(height: 12),
                  CustomIconButton(
                    color: Colors.pinkAccent,
                    icon: Icons.book_outlined,
                    label: 'Check Area for study',
                    onPressed: () {
                      log('Check Area for studyr');
                    },
                  ),
                  SizedBox(height: 12),
                  CustomIconButton(
                    color: Colors.limeAccent,
                    icon: Icons.lightbulb,
                    label: 'Revision Planner',
                    onPressed: () {
                      log('Revision Planner');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
