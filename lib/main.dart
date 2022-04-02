import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mobx/screens/login_screen.dart';
import 'package:todo_mobx/store/login_store.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<LoginStore>(
      create: (_) => LoginStore(),
      child: MaterialApp(
        title: "Todo List Mobx",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.deepPurpleAccent,
            cursorColor: Colors.deepPurpleAccent,
            scaffoldBackgroundColor: Colors.deepPurpleAccent),
        home: LoginScreen(),
      ),
    );
  }
}
