import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notice_news/src/models/category_model.dart';

import 'package:notice_news/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY = '74f383fc15c9492f855a68abcbd90651';



class NewsService with ChangeNotifier {

  List<Article> headlines = [];
  String _selectedCategory = 'business';

  bool _isLoading = true;

  List<Category> categories = [
    Category( FontAwesomeIcons.building, 'business' ),
    Category( FontAwesomeIcons.tv, 'entertainment' ),
    Category( FontAwesomeIcons.addressCard, 'general' ),
    Category( FontAwesomeIcons.headSideVirus, 'health' ),
    Category( FontAwesomeIcons.vials, 'science' ),
    Category( FontAwesomeIcons.volleyballBall, 'sports' ),
    Category( FontAwesomeIcons.memory, 'technology' ),
  ];
  //business entertainment general health science sports technology

  Map<String, List<Article>> categoryArticles = {};

  NewsService(){    
    this.getTopHeadlines();

    categories.forEach((item) {
      this.categoryArticles[item.name] = new List();
    }
    );
  }

  bool get isLoading => this._isLoading;

  getTopHeadlines() async{

    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ca';

    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson( resp.body );
    
    this.headlines.addAll( newsResponse.articles );

    notifyListeners();
  }

  get selectedCategory => this._selectedCategory;

  set selectedCategory(String valor ){
    this._selectedCategory = valor;

    this.getCategorias(valor);
    notifyListeners();
  }

  getCategorias(String category) async {

    if ( this.categoryArticles[category].length > 0 ) {

      this._isLoading = false;
      notifyListeners();
      return this.categoryArticles[category];
    }

    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ca&category=$category';

    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson( resp.body );
    
    this.categoryArticles[category].addAll( newsResponse.articles );

    this._isLoading = false;  

    notifyListeners();

  }  

  List<Article> get getArticulosCategoriaSelect 
     => this.categoryArticles[this.selectedCategory];

}