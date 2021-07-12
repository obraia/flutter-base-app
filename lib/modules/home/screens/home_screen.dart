import 'package:base_app/shared/widgets/bottom_navbar.dart';
import 'package:base_app/shared/widgets/list.dart';
import 'package:base_app/shared/widgets/popup_menu.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Color _backgroundColor = Color(0xFFFFFFFF);
  final Color _textColor = Color(0xFF5C5C5C);

  final _menuItems = [
    new MenuItem('Settings', Icons.settings, Color(0xFF5C5C5C)),
    new MenuItem('About', Icons.info, Color(0xFF5C5C5C)),
  ];

  void _onSelectedMenuItem(BuildContext context, int item) {
    switch (item) {
      case 0:
        print('Settings');
        break;
      case 1:
        print('About');
        break;
      default:
    }
  }

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
          actions: [PopupMenu(_onSelectedMenuItem, _menuItems)],
        ),
        body: List(),
        bottomNavigationBar: BottomNavbar(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
