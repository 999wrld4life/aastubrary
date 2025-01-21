import 'package:animated_book_widget/animated_book_widget.dart';
import 'package:day_1/bloc/favorite_bloc.dart';
import 'package:day_1/consttants.dart';
import 'package:day_1/model/book.dart';
import 'package:day_1/screens/details_screen.dart';
import 'package:day_1/screens/pdfviewer_screen.dart';
import 'package:day_1/service/book_repository.dart';
import 'package:day_1/widgets/book_rating.dart';
import 'package:day_1/widgets/two_side_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadingListCard extends StatefulWidget {
  final String? image;
  final String? title;
  final String? auth;
  final double? rating;
  final Function()? pressDetails;
  final Function()? pressRead;
  final Book book;

  const ReadingListCard({
    super.key,
    this.image,
    this.title,
    this.auth,
    this.rating,
    this.pressDetails,
    this.pressRead,
    required this.book,
  });

  @override
  State<ReadingListCard> createState() => _ReadingListCardState();
}

class _ReadingListCardState extends State<ReadingListCard> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(const FetchFavoriteBooks());
  }

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedBookWidget(
      blurRadius: 20,
      padding: const EdgeInsets.only(left: 20, right: 15),
      size: const Size(250, 100),
      content: Image.asset(widget.book.imagePath),
      cover: Container(
        margin: const EdgeInsets.only(left: 24, bottom: 40),
        height: 245,
        width: 202,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 221,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(29),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 33,
                      color: kShadowColor,
                    ),
                  ],
                ),
              ),
            ),
            Image.asset(
              widget.book.imagePath,
              width: 150,
              height: 150,
              // fit: BoxFit.cover,
            ),
            Positioned(
              top: 35,
              right: 10,
              child: Column(
                children: <Widget>[
                  BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, state) {
                      IconData icon = Icons.favorite_border;
                      if (state is FavoriteLoaded &&
                          state.favoriteBooks.contains(widget.book)) {
                        icon = Icons.favorite;
                      }
                      return IconButton(
                        icon: Icon(icon),
                        onPressed: () {
                          if (icon == Icons.favorite_border) {
                            context
                                .read<FavoriteBloc>()
                                .add(AddToFavorite(widget.book));
                          } else {
                            context
                                .read<FavoriteBloc>()
                                .add(RemoveFromFavorite(widget.book));
                          }
                        },
                      );
                    },
                  ),
                  BookRating(
                    rating: widget.book.rating,
                    book: widget.book,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 160,
              child: Container(
                height: 85,
                width: 202,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: RichText(
                        maxLines: 2,
                        text: TextSpan(
                          style: const TextStyle(color: kBlackColor),
                          children: [
                            TextSpan(
                              text: "${widget.book.title}\n",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: widget.book.author,
                              style: const TextStyle(
                                color: kLightBlackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return DetailsScreen(
                                  book: widget.book,
                                );
                              },
                            ));
                          },
                          child: Container(
                            width: 101,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            child: const Text("Details"),
                          ),
                        ),
                        Expanded(
                          child: TwoSideRoundedButton(
                            text: "Read",
                            press: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return PdfviewerScreen(
                                      pdfPath: widget.book.pdfPath);
                                },
                              ));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
