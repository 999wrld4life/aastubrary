import 'package:day_1/model/book.dart';
import 'package:day_1/screens/details_screen.dart';
import 'package:day_1/service/books_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showSearch(
        context: context,
        delegate: CustomSearchDelegate(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: const Icon(
              Icons.search,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            alignment: Alignment.topCenter,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<Book> books = BooksList.allBooks;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Book> bookQuery = [];
    for (var book in books) {
      if (book.title.toLowerCase().contains(query.toLowerCase())) {
        bookQuery.add(book);
      }
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 7),
      itemCount: bookQuery.length,
      itemBuilder: (context, index) {
        final book = bookQuery[index];
        return ListTile(
          title: Text(book.title),
          onTap: () {},
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Book> bookQuery = [];
    for (var book in books) {
      if (book.title.toLowerCase().contains(query.toLowerCase())) {
        bookQuery.add(book);
      }
    }

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg.png"),
          alignment: Alignment.topCenter,
          fit: BoxFit.fill,
        ),
      ),
      child: ListView.builder(
        itemCount: bookQuery.length,
        itemBuilder: (context, index) {
          final book = bookQuery[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text("By ${book.author}"),
            leading: Image.asset(book.imagePath),
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return DetailsScreen(
                    book: book,
                  );
                },
              ));
            },
          );
        },
      ),
    );
  }
}
