import 'package:flutter/material.dart';
import 'package:movlib/consts/colors.dart';
import 'package:movlib/view/search/search_view_model.dart';
import 'package:provider/provider.dart';

class SearchView extends StatelessWidget {
  static const route = 'search_view';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<SearchViewModel>(
      builder: (context, searchVM, child) {
        return Scaffold(
          appBar: AppBar(
            leading: Container(),
            actions: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => searchVM.onBackButtonPressed(context),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: Colors.white,
                  child: Center(
                    child: TextField(
                      onChanged: (value) => searchVM.onSearchChanged(value),
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.search,
                          size: 24,
                          color: KDark,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: KDarker,
                        fontSize: 18,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                      showCursor: true,
                      autofocus: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: ListView.builder(
            controller: searchVM.scrollController,
            itemCount: searchVM.movieCards.length,
            itemBuilder: (_context, index) {
                return searchVM.movieCards[index];
            },
          ),
        );
      },
    );
  }
}
