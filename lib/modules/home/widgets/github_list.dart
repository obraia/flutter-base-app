import 'package:base_app/modules/home/models/user.dart';
import 'package:base_app/modules/home/widgets/github_list_item.dart';
import 'package:base_app/shared/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GithubListState extends State<GithubList> {
  var _users = <User>[];
  final String baseUrl = 'https://api.github.com/users';

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

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Searchbar(
        widget: Container(
          child: ListView.separated(
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
                return index != 0 ? GithubListItem(_users[index]) : GithubListItemSpacer();
              }),
        ),
        placeholder: 'GitHub users',
        placeholderTyping: 'Search GitHub users...',
        onSubmit: _onSearchSubmitted);
  }
}

class GithubList extends StatefulWidget {
  @override
  createState() => new GithubListState();
}
