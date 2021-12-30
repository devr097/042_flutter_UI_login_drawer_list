import 'package:flutter/material.dart';
import 'package:sgmbooking/utils/appDrawer.dart';


class BlankPage extends StatefulWidget {
  const BlankPage({Key? key}) : super(key: key);

  @override
  _BlankPageState createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text("Blank Page"),
      ),
      drawer: appDrawer(context),
      body: Center(
        child: Text("Please draw your idea"),
      ),
    );
  }
}
