import 'package:base_app/modules/home/widgets/github_list.dart';
import 'package:base_app/shared/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Color _backgroundColor = Color(0xFFFFFFFF);
  final Color _textColor = Color(0xFF5C5C5C);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GitHub Users',
        home: Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: Text('GitHub Users', style: TextStyle(color: _textColor)),
            toolbarHeight: 50,
            backgroundColor: _backgroundColor,
          ),
          body: GithubList(),
          bottomNavigationBar: BottomNavbar(),
        ));
  }
}
