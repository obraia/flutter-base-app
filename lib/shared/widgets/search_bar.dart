import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class _SearchbarState extends State<Searchbar> {
  static const historyLength = 5;
  late FloatingSearchBarController _controller;

  List<String> _searchHistory = [];
  List<String> _filteredSearchHistory = [];

  String _selectedTerm = '';

  List<String> filterSearchTerms({
    required String filter,
  }) {
    if (filter.isNotEmpty) {
      return _searchHistory.reversed.where((term) => term.startsWith(filter)).toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSerchTerm(String term) {
    if (!_searchHistory.contains(term)) {
      _searchHistory.add(term);

      if (_searchHistory.length > historyLength) {
        _searchHistory.removeRange(0, _searchHistory.length - historyLength);
      }

      _filteredSearchHistory = filterSearchTerms(filter: '');
    } else {
      putSearchTermFirst(term);
    }
  }

  void deleteSearchTerm(String term) {
    _searchHistory.remove(term);
    _filteredSearchHistory = filterSearchTerms(filter: '');
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSerchTerm(term);
  }

  void handleSearch(String term) {
    setState(() {
      _searchHistory.contains(term) ? putSearchTermFirst(term) : addSerchTerm(term);
      _selectedTerm = term;
    });
    _controller.close();
    widget._onSubmit(term);
  }

  @override
  void initState() {
    super.initState();

    _controller = FloatingSearchBarController();
    _filteredSearchHistory = filterSearchTerms(filter: '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      controller: _controller,
      transition: CircularFloatingSearchBarTransition(),
      physics: BouncingScrollPhysics(),
      title: Text(_selectedTerm.isEmpty ? widget._placeholder : _selectedTerm),
      hint: widget._placeholderTyping,
      actions: [FloatingSearchBarAction.searchToClear()],
      borderRadius: BorderRadius.circular(10.0),
      shadowColor: Colors.black54,
      iconColor: Colors.grey,
      margins: const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
      onQueryChanged: (query) {
        setState(() {
          _filteredSearchHistory = filterSearchTerms(filter: query);
        });
      },
      onSubmitted: handleSearch,
      body: FloatingSearchBarScrollNotifier(child: widget._widget),
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
              color: Colors.white,
              elevation: 4,
              child: Builder(builder: (context) {
                if (_filteredSearchHistory.isEmpty && _controller.query.isEmpty) {
                  return Container(
                      height: 56,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text('Start searching', maxLines: 1, overflow: TextOverflow.ellipsis));
                } else if (_filteredSearchHistory.isEmpty) {
                  return ListTile(
                    title: Text(_controller.query),
                    leading: const Icon(
                      Icons.search,
                    ),
                    onTap: () => handleSearch(_controller.query),
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _filteredSearchHistory
                        .map((term) => ListTile(
                              title: Text(term, maxLines: 1, overflow: TextOverflow.ellipsis),
                              leading: const Icon(Icons.history),
                              trailing: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    deleteSearchTerm(term);
                                  });
                                },
                              ),
                              onTap: () => handleSearch(term),
                            ))
                        .toList(),
                  );
                }
              })),
        );
      },
    );
  }
}

class Searchbar extends StatefulWidget {
  late final Widget _widget;
  late final String _placeholder;
  late final String _placeholderTyping;
  late final Function _onSubmit;

  Searchbar(
      {required Widget widget,
      required String placeholder,
      required String placeholderTyping,
      required Function onSubmit}) {
    this._widget = widget;
    this._placeholder = placeholder;
    this._placeholderTyping = placeholderTyping;
    this._onSubmit = onSubmit;
  }

  @override
  State<StatefulWidget> createState() => _SearchbarState();
}
