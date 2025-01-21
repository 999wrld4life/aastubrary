import 'package:flutter_localization/flutter_localization.dart';

const List<MapLocale> LOCALES = [
  MapLocale('en', LocalData.EN),
  MapLocale('am', LocalData.AM),
  MapLocale('or', LocalData.OR),
  MapLocale('es', LocalData.ES),
  MapLocale('zh', LocalData.ZH),
];

mixin LocalData {
  static const String title = 'title';
  static const String bodyOne = 'bodyOne';
  static const String bodyTwo = 'bodyTwo';

  static const Map<String, dynamic> EN = {
    title: "Localization",
    bodyOne: "What are you reading today?",
    bodyTwo: "Best of the day",
  };

  static const Map<String, dynamic> AM = {
    title: "አካባቢያዊነት",
    bodyOne: "ዛሬ ምን እያነበብክ/ሽ ነው?",
    bodyTwo: "የቀኑ ምርጥ",
  };

  static const Map<String, dynamic> OR = {
    title: "naannootti jijjiiruu",
    bodyOne: "Har'a maal dubbisaa jirta?",
    bodyTwo: "Guyyaa sanaa keessaa isa gaarii",
  };

  static const Map<String, dynamic> ES = {
    title: "localización",
    bodyOne: '¿Qué estás leyendo hoy?',
    bodyTwo: "La mejor del dia",
  };

  static const Map<String, dynamic> ZH = {
    title: "本土化",
    bodyOne: "今天你在读什么？",
    bodyTwo: "今日精选",
  };
}
