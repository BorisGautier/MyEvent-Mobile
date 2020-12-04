import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myevent/src/bloc/auth/auth_bloc.dart';

class Home extends StatefulWidget {
  Home({Key key, this.name}) : super(key: key);
  final String name;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Flutter'),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Bienvenue " + widget.name),
            RaisedButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(
                  AuthLoggedOut(),
                );
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
