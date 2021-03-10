import 'screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'utils/constants.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'models/debt_profile.dart';
import 'package:hive/hive.dart';

void main() async {
  // This has to be the first line since in main
  // we are awaiting and runApp() is called before that
  // https://stackoverflow.com/questions/57689492/flutter-unhandled-exception-servicesbinding-defaultbinarymessenger-was-accesse
  WidgetsFlutterBinding.ensureInitialized();
  // refer

  final appDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  Hive.registerAdapter(DebtProfileAdapter());
  Hive.registerAdapter(TransactionAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
      ),
      initialRoute: rHomePage,
      routes: {
        rHomePage: (context) => HomePage(),
      },
    );
  }
}

// test
