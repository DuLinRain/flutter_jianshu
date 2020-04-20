import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jianshu/components/tab_navigator.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BotToastInit(
      child: MaterialApp(
        title: '简书',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            backgroundColor: Color(0xfff5f5f5),
            primaryColor: Color(0xffea6f5a),
            appBarTheme: AppBarTheme(
              elevation: 0
            ),
        ),
        home: TabNavigator(),
        navigatorObservers: [BotToastNavigatorObserver()],
        localizationsDelegates: [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate
        ],
        locale: const Locale('zh'),
        supportedLocales: [const Locale('en'), const Locale('zh')],
      ),
    );
  }
}
