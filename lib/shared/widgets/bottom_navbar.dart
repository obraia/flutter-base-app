import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationItem {
  late final List<Icon> _icons;
  late final String _title;
  late final Color _color;

  NavigationItem(this._icons, this._title, this._color);
}

class BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;
  final Color _backgroundColor = Color(0xFFFFFFFF);
  final Color _textColor = Color(0xFF5C5C5C);

  List<NavigationItem> _navigationItems = [
    NavigationItem([Icon(Icons.home), Icon(Icons.home_outlined)], 'Home', Color(0xFF5A40BB)),
    NavigationItem(
        [Icon(Icons.favorite), Icon(Icons.favorite_outline)], 'Favorites', Color(0xFFA75098)),
    NavigationItem([Icon(Icons.search), Icon(Icons.search_outlined)], 'Search', Color(0xFF82B943)),
    NavigationItem([Icon(Icons.person), Icon(Icons.person_outlined)], 'Profile', Color(0xFFAD4A4A)),
  ];

  Widget _buildItem(NavigationItem item, bool isSelected) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: double.maxFinite,
      width: isSelected ? 120 : 60,
      decoration: BoxDecoration(
          color: isSelected ? item._color.withOpacity(0.25) : _backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: ListView(scrollDirection: Axis.horizontal, children: [
        Container(
          width: isSelected ? 120 : 60,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconTheme(
              child: isSelected ? item._icons[0] : item._icons[1],
              data: IconThemeData(size: 24, color: isSelected ? item._color : _textColor),
            ),
            isSelected
                ? Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      item._title,
                      style:
                          TextStyle(color: item._color, fontSize: 12, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ))
                : Container()
          ]),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 56,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: _backgroundColor, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 1)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _navigationItems.map((item) {
          int itemIndex = _navigationItems.indexOf(item);

          return GestureDetector(
            child: _buildItem(item, _selectedIndex == itemIndex),
            onTap: () {
              if (_selectedIndex != itemIndex) {
                setState(() {
                  _selectedIndex = itemIndex;
                });
              }
            },
          );
        }).toList(),
      ),
    );
  }
}

class BottomNavbar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new BottomNavbarState();
}
