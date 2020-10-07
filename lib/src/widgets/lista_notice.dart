import 'package:flutter/material.dart';
import 'package:notice_news/src/models/news_models.dart';
import 'package:notice_news/src/theme/dark_theme.dart';


class ListaNotice extends StatelessWidget {
  
  final List<Article> noticias;
  
  const ListaNotice(
    this.noticias
  );
  
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (context, index) {        
        return _Noticia(noticia: this.noticias[index], index: index);
      },
      
      );
  }

}

class _Noticia extends StatelessWidget {
  
  final Article noticia;
  final int index;

  const _Noticia({@required this.noticia, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: <Widget>[
        _TarjetaTopBar(noticia, index),
        _TarjetaTitulo(noticia),
        _TarjetaImagen(noticia),
        _TarjetaBody(noticia),
        _TarjetaBotones(),
        SizedBox(height: 10.0,),
        Divider(),

      ],
    );
  }
  
}

class _TarjetaBotones extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            child: Icon(Icons.share),
            onPressed: (){},
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            fillColor: Colors.blue,
          ),
          SizedBox(width: 10,),
          RawMaterialButton(
            child: Icon(Icons.star_border),
            onPressed: (){},
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            fillColor: Colors.yellow[700],
          ),
        ],
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  
  final Article noticia;

  const _TarjetaBody( this.noticia );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (noticia.description != null ) ? Text( noticia.description ) : Text(''),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  
  final Article noticia;

  const _TarjetaImagen(this.noticia);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50) ),
          child: Container(
          child: FadeInImage(
              placeholder: AssetImage('assets/img/giphy.gif'), 
              image: (noticia.urlToImage != null ) ?  NetworkImage( noticia.urlToImage) : AssetImage('assets/img/no-image.png')
            )
        ),
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  
  final Article noticia;

  const _TarjetaTitulo( this.noticia);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text( noticia.title, style: TextStyle( fontSize: 20, fontWeight: FontWeight.w700),),
      
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  
  final Article noticia;
  final int index;

  const _TarjetaTopBar( this.noticia, this.index );  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text('> ${ index +1 }  ', style: TextStyle( color: miTema.accentColor),),
          Text('${ noticia.source.name }, ', style: TextStyle( color: miTema.accentColor),)
        ],
      ),
    );
  }
}