import 'package:base_app/modules/home/models/user.dart';
import 'package:base_app/shared/utils/color.dart';
import 'package:flutter/material.dart';

class ListItemSpacer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
    );
  }
}

class ListItem extends StatelessWidget {
  final User _user;
  final _font = const TextStyle(fontFamily: 'Roboto', fontSize: 20, color: Color(0xFF5C5C5C));
  final Color _backgroundColor = Color(0xFFFFFFFF);

  ListItem(this._user);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 75,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [BoxShadow(color: Color(0xFFE9E9E9), blurRadius: 5.0)]),
        child: ListTile(
          title: Text('${_user.login}', style: _font),
          leading: CircleAvatar(
            backgroundColor: ColorUtil.fromHex('#d9d9d9'),
            backgroundImage: NetworkImage(_user.avatarUrl),
          ),
        ));
  }
}
