import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:day_1/bloc/favorite_bloc.dart';
import 'package:day_1/main.dart';
import 'package:day_1/model/book.dart';
import 'package:day_1/screens/details_screen.dart';
import 'package:day_1/screens/pdfviewer_screen.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';
import 'package:super_tooltip/super_tooltip.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(const FetchFavoriteBooks());
  }

  final _controller = SuperTooltipController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            alignment: Alignment.topCenter,
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Favorites',
                    style: TextStyle(fontSize: 30),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await _controller.showTooltip();
                    },
                    child: SuperTooltip(
                      controller: _controller,
                      showBarrier: true,
                      showDropBoxFilter: true,
                      sigmaX: 10,
                      sigmaY: 10,
                      constraints: const BoxConstraints(maxHeight: 100),
                      hasShadow: true,
                      hideTooltipOnTap: true,
                      hideTooltipOnBarrierTap: true,
                      content: const Text(
                          'Drag to reorder your favorite books as you like!'),
                      child: const Icon(Icons.info_outline),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, state) {
                  if (state is FavoriteLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FavoriteLoaded) {
                    final favoriteBooks = state.favoriteBooks;
                    if (favoriteBooks.isEmpty) {
                      return const Center(
                        child: Text(
                          "No Favorite Books",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    return ReorderableListView.builder(
                      onReorder: (oldIndex, newIndex) {
                        setState(() {
                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }
                        });
                        final item = favoriteBooks.removeAt(oldIndex);
                        favoriteBooks.insert(newIndex, item);
                      },
                      itemCount: favoriteBooks.length,
                      itemBuilder: (context, index) {
                        final favoriteBook = favoriteBooks[index];
                        return KeyedSubtree(
                          key: ValueKey(favoriteBook.title),
                          child: FavoritesComponent(book: favoriteBook),
                        );
                      },
                    );
                  } else if (state is FavoriteError) {
                    return Center(
                      child: Text(
                        state.error,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        "No Favorite Books",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritesComponent extends StatefulWidget {
  final Book book;

  const FavoritesComponent({
    super.key,
    required this.book,
  });

  @override
  State<FavoritesComponent> createState() => _FavoritesComponentState();
}

class _FavoritesComponentState extends State<FavoritesComponent> {
  final _controller = SuperTooltipController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/images/bg.png"),
          alignment: Alignment.topCenter,
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            offset: Offset(15, 15),
            blurRadius: 24,
            color: Colors.grey,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: PopupMenuButton<String>(
              onOpened: () async {
                await _controller.showTooltip();
              },
              iconSize: 28,
              onSelected: (value) {
                if (value == "Delete") {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.warning,
                    animType: AnimType.rightSlide,
                    title: 'Are you sure?',
                    desc: 'Delete book from favorites?',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      ElegantNotification.success(
                        position: Alignment.bottomRight,
                        title: const Text('Successfully deleted'),
                        description: const Text('Book deleted from favorites'),
                      ).show(context);
                      context
                          .read<FavoriteBloc>()
                          .add(RemoveFromFavorite(widget.book));
                    },
                  ).show();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: "Delete",
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 5),
                      Text('Delete')
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Image.asset(
                widget.book.imagePath,
                height: 150,
                width: 150,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.book.title,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      widget.book.author,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return DetailsScreen(book: widget.book);
                              },
                            ));
                          },
                          child: const Text('Details'),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
