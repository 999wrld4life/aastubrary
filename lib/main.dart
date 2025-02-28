import 'package:day_1/bloc/favorite_bloc.dart';
import 'package:day_1/consttants.dart';
import 'package:day_1/localization/local.dart';
import 'package:day_1/screens/favorites_screen.dart';
import 'package:day_1/screens/home_screen.dart';
import 'package:day_1/screens/main_screen.dart';
import 'package:day_1/screens/onboarding_screen.dart';
import 'package:day_1/screens/search_screen.dart';
import 'package:day_1/screens/seemore_screen.dart';
import 'package:day_1/screens/splash.dart';
import 'package:day_1/service/book_repository.dart';
import 'package:day_1/widgets/onboarding_btn.dart';
import 'package:day_1/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';

void main() => runApp(BlocProvider(
      create: (context) => FavoriteBloc(BookRepository()),
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(
              displayColor: kBlackColor,
            ),
      ),
      home: const SplashScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Bitmap.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.displayMedium,
                children: const [
                  TextSpan(
                    text: "aastubra",
                  ),
                  TextSpan(
                    text: "ry.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .6,
              child: RoundedButton(
                text: "start reading",
                fontSize: 20,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const MainScreen();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
