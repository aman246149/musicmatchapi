import 'package:flutter/material.dart';

class NotConnected extends StatelessWidget {
  const NotConnected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Internet Not Connected"),
      ),
    );
  }
}
