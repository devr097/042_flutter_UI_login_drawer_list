import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgmbooking/screens/login.dart';
import 'package:sgmbooking/service/netService.dart';

void main() {
  runApp(MultiProvider(
    providers: [
        ChangeNotifierProvider(create: (_) => NetworkBloc())],
    child: MyApp(),));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,

      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
