import 'dart:async';

import 'package:day_1/bloc/favorite_bloc.dart';
import 'package:day_1/consttants.dart';
import 'package:day_1/model/book.dart';
import 'package:day_1/screens/details_screen.dart';
import 'package:day_1/screens/pdfviewer_screen.dart';
import 'package:day_1/service/books_list.dart';
import 'package:day_1/widgets/book_rating.dart';
import 'package:day_1/widgets/reading_card_list.dart';
import 'package:day_1/widgets/two_side_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 12), () {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocListener<FavoriteBloc, FavoriteState>(
      listener: (context, state) {
        if (state is FavoriteAdded) {
          const snackbar = SnackBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                  title: 'Book Added!',
                  message: "Book added to favorites",
                  contentType: ContentType.success));

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackbar);
        } else if (state is FavoriteError) {
          const snackbar = SnackBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                  title: 'Book Already Added to Favorites!',
                  message:
                      "Book has been already added to your favorite's page",
                  contentType: ContentType.failure));

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackbar);
        } else if (state is FavoriteRemoved) {
          const snackbar = SnackBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Book Removed!',
              message: "Book removed from favorites",
              contentType: ContentType.success,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackbar);
        }
      },
      child: Scaffold(
        body: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/main_page_bg.png"),
                            alignment: Alignment.topCenter,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: size.height * .1),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: RichText(
                                text: TextSpan(
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                  children: const [
                                    TextSpan(text: "What are you \nreading "),
                                    TextSpan(
                                        text: "today?",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            // ignore: sized_box_for_whitespace
                            Container(
                              width: double.infinity,
                              height: 285,
                              child: Skeletonizer(
                                enabled: _loading,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: BooksList.homePageBooksOne.length,
                                  itemBuilder: (context, index) {
                                    final book =
                                        BooksList.homePageBooksOne[index];
                                    return ReadingListCard(book: book);
                                  },
                                ),
                              ),
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                      children: const [
                                        TextSpan(text: "Best of the "),
                                        TextSpan(
                                          text: "day",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  bestOfTheDayCard(size, context),
                                  const SizedBox(height: 10),
                                  const Divider(),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: RichText(
                                          text: TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                            children: const [
                                              TextSpan(text: "Business "),
                                              TextSpan(
                                                text: "Books",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'See More >',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  // ignore: sized_box_for_whitespace
                                  Container(
                                    width: double.infinity,
                                    height: 285,
                                    child: Skeletonizer(
                                      enabled: _loading,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            BooksList.businessBooks.length,
                                        itemBuilder: (context, index) {
                                          final book =
                                              BooksList.businessBooks[index];
                                          return ReadingListCard(book: book);
                                        },
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                      // indent: 10,
                                      // endIndent: 10,
                                      ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 1),
                                        child: RichText(
                                          text: TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                            children: const [
                                              TextSpan(text: "Programming "),
                                              TextSpan(
                                                text: "Books",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'See More >',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  // ignore: sized_box_for_whitespace
                                  Container(
                                    width: double.infinity,
                                    height: 285,
                                    child: Skeletonizer(
                                      enabled: _loading,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            BooksList.programmingBooks.length,
                                        itemBuilder: (context, index) {
                                          final book =
                                              BooksList.programmingBooks[index];
                                          return ReadingListCard(book: book);
                                        },
                                      ),
                                    ),
                                  ),

                                  RichText(
                                    text: TextSpan(
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                      children: const [
                                        TextSpan(text: "Continue "),
                                        TextSpan(
                                          text: "reading...",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    height: 80,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(38.5),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(0, 10),
                                          blurRadius: 33,
                                          color: const Color(0xFFD3D3D3)
                                              .withOpacity(.84),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(38.5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30, right: 20),
                                              child: Row(
                                                children: <Widget>[
                                                  const Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          "Crushing & Influence",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Gary Venchuk",
                                                          style: TextStyle(
                                                            color:
                                                                kLightBlackColor,
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: Text(
                                                            "Chapter 7 of 10",
                                                            style: TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  kLightBlackColor,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                      ],
                                                    ),
                                                  ),
                                                  Image.asset(
                                                    "assets/images/programming books/62608971.jpg",
                                                    width: 55,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 7,
                                            width: size.width * .65,
                                            decoration: BoxDecoration(
                                              color: kProgressIndicator,
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: RichText(
                                          text: TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                            children: const [
                                              TextSpan(text: "Amharic "),
                                              TextSpan(
                                                text: "Fictions",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'See More >',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  // ignore: sized_box_for_whitespace
                                  Container(
                                    width: double.infinity,
                                    height: 285,
                                    child: Skeletonizer(
                                      enabled: _loading,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: BooksList
                                            .amharicFictionBooks.length,
                                        itemBuilder: (context, index) {
                                          final book = BooksList
                                              .amharicFictionBooks[index];
                                          return ReadingListCard(book: book);
                                        },
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                            children: const [
                                              TextSpan(text: "English "),
                                              TextSpan(
                                                text: "Fictions",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            'See More >',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  // ignore: sized_box_for_whitespace
                                  Container(
                                    width: double.infinity,
                                    height: 285,
                                    child: Skeletonizer(
                                      enabled: _loading,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: BooksList
                                            .englishFictionBooks.length,
                                        itemBuilder: (context, index) {
                                          final book = BooksList
                                              .englishFictionBooks[index];
                                          return ReadingListCard(book: book);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (state is FavoriteLoading)
                  Center(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const SpinKitFadingFour(
                        color: Colors.black,
                        size: 50,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Container bestOfTheDayCard(Size size, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      height: 260,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: 24,
                top: 24,
                right: size.width * .35,
              ),
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFEAEAEA).withOpacity(.45),
                borderRadius: BorderRadius.circular(29),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: const Text(
                      "New York Time Best For 11th March 2020",
                      style: TextStyle(
                        fontSize: 9,
                        color: kLightBlackColor,
                      ),
                    ),
                  ),
                  Text(
                    "How To Win \nFriends &  Influence",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Text(
                    "Gary Venchuk",
                    style: TextStyle(color: kLightBlackColor),
                  ),
                  const Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: BookRating(
                          rating: 4.9,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "When the earth was flat and everyone wanted to win the game of the best and people….",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            color: kLightBlackColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset(
              "assets/images/english books/book-3.png",
              width: size.width * .37,
              // height: 170,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              height: 40,
              width: size.width * .3,
              child: TwoSideRoundedButton(
                text: "Read",
                radious: 24,
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const PdfviewerScreen(
                          pdfPath:
                              'assets/pdfs/how-to-win-friends-and-influence-people.pdf');
                    },
                  ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
