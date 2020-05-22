import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tab1_page.dart';
import 'package:newsapp/src/pages/tab2_page.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:provider/provider.dart';
// 62b8ad162390455fba6e68b77c0e0c3e
class TabsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavegacionModel(),
        child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: 
          _Navegacion(),
        ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener instancia de Provider
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (index) => navegacionModel.paginaActual = index,
      items: [
      BottomNavigationBarItem(icon: Icon(Icons.person_outline), title: Text('Para ti')),
      BottomNavigationBarItem(icon: Icon(Icons.public), title: Text('Encabezados')),
    ]
    );
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
       controller: navegacionModel.pageController ,
      // physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Tab1Page(),
        Tab2Page()
      ],
    );
  }
}

// Provider
class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  PageController _pageController = PageController(
    initialPage: 0
  );

  int get paginaActual => this._paginaActual;

  set paginaActual(int valor) {
    this._paginaActual = valor;
    _pageController.animateToPage(valor,
     duration: Duration(milliseconds: 250),
      curve: Curves.easeOut
      );
    // ???
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}