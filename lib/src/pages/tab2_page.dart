import 'package:flutter/material.dart';
import 'package:notice_news/src/models/category_model.dart';
import 'package:notice_news/src/services/news_service.dart';
import 'package:provider/provider.dart';

class Tabs2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: _ListaCategorias()
            )
          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;
    
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {

          final cName = categories[index].name;

        return Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              _CategoryButton(categories[index]),
              SizedBox(height: 5.0,),
              Text( '${ cName[0].toUpperCase() }${ cName.substring(1) }' ),
            ],
          )
        
        );
      },

    );
  }
}

class _CategoryButton extends StatelessWidget {
 
  final Category categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          final newsService = Provider.of<NewsService>(context, listen: false);
          newsService.selectedCategory = categoria.name;
        },
        child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon( 
          categoria.icon,
          color: Colors.black54
        ),
      ),
    );
    
    Icon( categoria.icon);
  }
}