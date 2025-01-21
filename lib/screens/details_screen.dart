import 'dart:developer';

import 'package:day_1/bloc/favorite_bloc.dart';
import 'package:day_1/consttants.dart';
import 'package:day_1/model/book.dart';
import 'package:day_1/screens/pdfviewer_screen.dart';
import 'package:day_1/service/books_list.dart';
import 'package:day_1/widgets/book_rating.dart';
import 'package:day_1/widgets/neopop_button.dart';
import 'package:day_1/widgets/reading_card_list.dart';
import 'package:day_1/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatelessWidget {
  final Book? book;
  Book sampleBook = Book(
      title: "How To Win \nFriends & Influence \n",
      imagePath: "assets/images/english books/book-3.png",
      description: '',
      author: "Gary Venchuk",
      rating: 4.9);

  DetailsScreen({super.key, this.book});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(
                        top: size.height * .12,
                        left: size.width * .1,
                        right: size.width * .02),
                    height: size.height * .48,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/bg.png"),
                        fit: BoxFit.fitWidth,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: BookInfo(
                      book: book!,
                      size: size,
                    )),
                Padding(
                  padding: EdgeInsets.only(top: size.height * .48 - 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ChapterCard(
                        name: "Money",
                        chapterNumber: 1,
                        tag: "Life is about change",
                        press: () {},
                      ),
                      ChapterCard(
                        name: "Power",
                        chapterNumber: 2,
                        tag: "Everything loves power",
                        press: () {},
                      ),
                      ChapterCard(
                        name: "Influence",
                        chapterNumber: 3,
                        tag: "Influence easily like never before",
                        press: () {},
                      ),
                      ChapterCard(
                        name: "Win",
                        chapterNumber: 4,
                        tag: "Winning is what matters",
                        press: () {},
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Center(
              child: BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, state) {
                  String btnName = "Add to Favorites";
                  if (state is FavoriteLoaded &&
                      state.favoriteBooks.contains(book)) {
                    btnName = "Remove from Favorites";
                  }
                  return MyNeopopButton(
                    text: btnName,
                    onTapDown: () {
                      if (btnName == "Add to Favorites") {
                        context.read<FavoriteBloc>().add(AddToFavorite(book!));
                      } else {
                        context
                            .read<FavoriteBloc>()
                            .add(RemoveFromFavorite(book!));
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              endIndent: 10,
              indent: 10,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.headlineSmall,
                      children: const [
                        TextSpan(
                            text: "You might also ",
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                          text: "like...",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),

                  // const SizedBox(height: 10),
                  Stack(
                    children: <Widget>[
                      // ignore: sized_box_for_whitespace
                      Container(
                        height: 180,
                        width: double.infinity,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 24, top: 24, right: 150),
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(29),
                            color: const Color(0xFFFFF8F9),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(color: kBlackColor),
                                  children: [
                                    TextSpan(
                                      text: sampleBook.title,
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    TextSpan(
                                      text: sampleBook.author,
                                      style: const TextStyle(
                                          color: kLightBlackColor),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  BookRating(
                                    book: book,
                                    rating: sampleBook.rating,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: RoundedButton(
                                      text: "Read",
                                      verticalPadding: 10,
                                      press: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return const PdfviewerScreen(
                                                pdfPath:
                                                    'assets/pdfs/how-to-win-friends-and-influence-people.pdf');
                                          },
                                        ));
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Image.asset(
                          sampleBook.imagePath,
                          width: 150,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.headlineSmall,
                            children: const [
                              TextSpan(
                                  text: "More ",
                                  style:
                                      TextStyle(fontStyle: FontStyle.italic)),
                              TextSpan(
                                text: "Books",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
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
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: BooksList.businessBooks.length,
                      itemBuilder: (context, index) {
                        final book = BooksList.businessBooks[index];
                        return ReadingListCard(book: book);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

class ChapterCard extends StatelessWidget {
  final String? name;
  final String? tag;
  final int? chapterNumber;
  final Function()? press;
  const ChapterCard({
    super.key,
    this.name,
    this.tag,
    this.chapterNumber,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      margin: const EdgeInsets.only(bottom: 16),
      width: size.width - 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(38.5),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 33,
            color: const Color(0xFFD3D3D3).withOpacity(.84),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Chapter $chapterNumber : $name \n",
                  style: const TextStyle(
                    fontSize: 16,
                    color: kBlackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: tag,
                  style: const TextStyle(color: kLightBlackColor),
                ),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
            onPressed: press,
          )
        ],
      ),
    );
  }
}

class BookInfo extends StatelessWidget {
  final Book book;
  const BookInfo({
    super.key,
    this.size,
    required this.book,
  });

  final Size? size;

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      book.title,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: size!.width * .32,
                            padding: EdgeInsets.only(top: size!.height * .02),
                            child: Text(
                              book.description,
                              maxLines: 8,
                              style: const TextStyle(
                                fontSize: 10,
                                color: kLightBlackColor,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: size!.height * .015),
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return PdfviewerScreen(
                                        pdfPath: book.pdfPath);
                                  },
                                ));
                              },
                              child: const Text(
                                "Read",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(
                              Icons.favorite_border,
                              size: 20,
                              color: Colors.grey,
                            ),
                            onPressed: () {},
                          ),
                          BookRating(
                            book: book,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              )),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.transparent,
              child: Image.asset(
                book.imagePath,
                height: double.infinity,
                alignment: Alignment.topRight,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
