import 'package:flutter/material.dart';
import 'package:notice_news/src/models/news_models.dart';
import 'package:notice_news/src/theme/dark_theme.dart';


class ListaNoticeMain extends StatelessWidget {
  
  final List<Article> noticias; 
  
  const ListaNoticeMain(
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

    final size = MediaQuery.of(context).size.width;

    return Column(      
      children: <Widget>[
        Stack(
          children: [                       
            _TarjetaImagen(noticia),
            Positioned(
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(   
                    width: size,                 
                    child: Row(                          
                          children: [
                            _TarjetaSourceNoticeBar(noticia, index),
                            Expanded( child: SizedBox(width: 1)),
                            _TarjetaHourBar(noticia, index)
                          ],
                        ),
                  ),
                  _TarjetaTitulo(noticia),                
                ],
              ),
            ),
            
            //_TarjetaBody(noticia),
            Positioned(
              top: 2,
              right: 2,              
              child: _TarjetaBotones(),
            ),            
            //SizedBox(height: 10.0,),
            Divider(),
          ],
        )
        

      ],
    );
  }
  
}



class _TarjetaBotones extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 50,
      child: Column(        
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 3,),
          Expanded(
            child: FlatButton(
                      //padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),                    
                      child: Icon(Icons.share, size: 15, color: Colors.white,),
                      onPressed: (){},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      color: Color.fromRGBO(50, 70, 170, 0.6),                    
                      ),
          ),          
          SizedBox(height: 3,),
          Expanded(
                      child: FlatButton(
                            child: Icon(Icons.star_border, size: 15, color: Colors.yellow,),
                            onPressed: (){},
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            color: Color.fromRGBO(50, 70, 170, 0.6), 
                            ),
          ),
          SizedBox(height: 3,),                    
          Expanded(
                      child: FlatButton(
                            child: Icon(Icons.not_interested, size: 15, color: Colors.red,),
                            onPressed: (){},
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            color: Color.fromRGBO(50, 70, 170, 0.6), 
                            ),
          ),
          SizedBox(height: 3,),
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

    final size = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
      height: 75,
      width: size,
      color: Color.fromRGBO(0, 0, 0, 0.4),
      child: 
          Text( noticia.title, maxLines: 3, style: TextStyle( fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),),
      
    );
  }
}

class _TarjetaSourceNoticeBar extends StatelessWidget {
  
  final Article noticia;
  final int index;

  const _TarjetaSourceNoticeBar( this.noticia, this.index );  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      color: Colors.red[600],
      padding: EdgeInsets.only(left: 5),
      child: Flexible(
              fit: FlexFit.tight,
              child: Text('${ noticia.source.name } ', style: TextStyle( color: Colors.white),)                      
              ),
    );
  }
}

class _TarjetaHourBar extends StatelessWidget {

  final Article noticia;
  final int index;

  const _TarjetaHourBar( this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      color: Color.fromRGBO(0, 95, 130, 0.6),
      child: Flexible(
              fit: FlexFit.tight,
              child: Text(' ${ noticia.publishedAt.day }/${ noticia.publishedAt.month }/${ noticia.publishedAt.year } ', style: TextStyle( color: Colors.white),)                      
              ),
    );
  }
}