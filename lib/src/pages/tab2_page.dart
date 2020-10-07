import 'package:flutter/material.dart';
import 'package:notice_news/src/models/category_model.dart';
import 'package:notice_news/src/services/news_service.dart';
import 'package:notice_news/src/theme/dark_theme.dart';
import 'package:notice_news/src/widgets/lista_notice.dart';
import 'package:provider/provider.dart';

class Tabs2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
          child: Scaffold(
        body: Column(
          children: <Widget>[
                _ListaCategorias(),
                Expanded(
                  child: ListaNotice( newsService.getArticulosCategoriaSelect ),
                ),            
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
    
    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
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
            ),
            
          );
        },

      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
 
  final Category categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {

    final newService = Provider.of<NewsService>(context);

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
          color: ( newService.selectedCategory == this.categoria.name ) 
                  ? miTema.accentColor 
                  : Colors.black54
        ),
      ),
    );
    
    Icon( categoria.icon);
  }
}