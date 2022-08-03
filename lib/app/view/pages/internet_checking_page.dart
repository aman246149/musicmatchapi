import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/app/view/pages/homepage.dart';

import '../bloc/InternetBloc/internet_bloc.dart';
import '../bloc/InternetBloc/internet_state.dart';
import 'not_connected_page.dart';

class InterNetCheckingPage extends StatefulWidget {
  InterNetCheckingPage({Key? key}) : super(key: key);

  @override
  State<InterNetCheckingPage> createState() => _InterNetCheckingPageState();
}

class _InterNetCheckingPageState extends State<InterNetCheckingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            BlocConsumer<ConnectedBloc, ConnectedState>(
              listener: (context, state) {
                if (state is ConnectedSucessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Internet Connected')));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                } else if (state is ConnectedFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Internet Lost')));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotConnected(),
                      ));
                }
              },
              builder: (context, state) {
                // if (state is ConnectedFailureState) {
                //   return Center(
                //     child: Text("Internet Not Connected"),
                //   );
                // }
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text("Internet Not Connected"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
