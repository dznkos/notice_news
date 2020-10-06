import 'package:flutter/material.dart';

import 'package:notice_news/src/pages/tabs_page.dart';
import 'package:notice_news/src/services/news_service.dart';
import 'package:notice_news/src/theme/dark_theme.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> new NewsService() ),
        ],
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: miTema,
        home: TabsPage()
      ),
    );
  }
}