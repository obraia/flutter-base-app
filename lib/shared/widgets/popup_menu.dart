import 'package:flutter/material.dart';

class PopupMenu extends StatelessWidget {
  final Color _textColor = Color(0xFF5C5C5C);
  late final Function _onSelected;
  late final List<MenuItem> _items;

  PopupMenu(this._onSelected, this._items);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
        onSelected: (item) => _onSelected(context, item),
        icon: Icon(Icons.more_vert, color: _textColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        elevation: 5,
        itemBuilder: (context) => _items
            .map((item) => PopupMenuItem(
                value: 0,
                child: Row(children: [
                  item._icon,
                  item._title,
                ])))
            .toList());
  }
}

class MenuItem {
  late final Text _title;
  late final Container _icon;

  MenuItem(String title, IconData icon, Color color) {
    _title = Text(title, style: TextStyle(color: color));
    _icon = Container(margin: const EdgeInsets.only(right: 10), child: Icon(icon, color: color));
  }
}
