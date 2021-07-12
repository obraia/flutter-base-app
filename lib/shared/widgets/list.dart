import 'package:base_app/modules/home/models/user.dart';
import 'package:base_app/shared/widgets/list_item.dart';
import 'package:base_app/shared/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListState extends State<List> {
  var _users = <User>[];
  final String baseUrl = 'https://api.github.com/users';
  bool _showBackToTopButton = false;
  late ScrollController _scrollController;

  _loadData() async {
    http.Response response = await http.get(Uri.parse(baseUrl));

    setState(() {
      final usersJSON = jsonDecode(response.body);

      for (var user in usersJSON) {
        _users.add(User.fromJson(user));
      }
    });
  }

  void _onSearchSubmitted(String searchTerm) {
    print(searchTerm);
  }

  void _scrollToTop() {
    _scrollController.animateTo(0, duration: Duration(milliseconds: 200), curve: Curves.linear);
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      setState(() {
        _showBackToTopButton = _scrollController.offset >= 400;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Searchbar(
        widget: Stack(children: [
          ListView.separated(
              controller: _scrollController,
              separatorBuilder: (BuildContext context, int index) {
                return index != 0
                    ? SizedBox(
                        height: 20,
                      )
                    : SizedBox(
                        height: 0,
                      );
              },
              padding: const EdgeInsets.all(20),
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return index != 0 ? ListItem(_users[index]) : ListItemSpacer();
              }),
          _showBackToTopButton
              ? Positioned(
                  bottom: 10,
                  right: 10,
                  child: FloatingActionButton(
                    onPressed: _scrollToTop,
                    child: Icon(
                      Icons.arrow_upward,
                      color: const Color(0xFFFFFFFF),
                    ),
                    backgroundColor: const Color(0xFF82B943),
                    elevation: 3,
                  ))
              : Container()
        ]),
        placeholder: 'GitHub users',
        placeholderTyping: 'Search GitHub users...',
        onSubmit: _onSearchSubmitted);
  }
}

class List extends StatefulWidget {
  @override
  createState() => new ListState();
}
