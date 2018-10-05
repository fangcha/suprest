import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import './ducks/state.dart';
import './ducks/product.dart';
import 'backdrop.dart';
import 'cart.dart';

void main() {
  final store = Store<AppState>(
    rootReducer,
    initialState: AppState.initial(),
  );
  runApp(App(store: store));
}

class App extends StatelessWidget {
  final Store<AppState> store;

  App({Key key, this.store}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: ProductList(title: 'SupRest POS'),
      ),
    );
  }
}

class ProductList extends StatefulWidget {
  ProductList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ProductListState createState() => new ProductListState();
}

class ProductListState extends State<ProductList> {
  // List<Map<String, dynamic>> _menu1 = const [
  //   {'img': 'img1', 'title': 'title1'},
  //   {'img': 'img2', 'title': 'title2'},
  //   {'img': 'img3', 'title': 'title3'},
  //   {'img': 'img4', 'title': 'title4'}
  // ];
  List<Map<String, dynamic>> _menu2 = const [
    {'img': 'img1', 'title': 'title1'},
    {'img': 'img2', 'title': 'title2'},
    {'img': 'img3', 'title': 'title3'},
    {'img': 'img4', 'title': 'title4'}
  ];
  List<Map<String, dynamic>> _menu3 = const [
    {'img': 'img1', 'title': 'title1'},
    {'img': 'img2', 'title': 'title2'},
    {'img': 'img3', 'title': 'title3'},
    {'img': 'img4', 'title': 'title4'}
  ];

  Widget _buildTabBarView(List<Map<String, dynamic>> menu) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: menu.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            print('clicked');
          },
          child: Card(
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(menu[index]['title']),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _tabBarView = TabBarView(
      children: <Widget>[
        Products(),
        _buildTabBarView(_menu2),
        _buildTabBarView(_menu3),
      ],
    );

    return DefaultTabController(
      length: 3,
      child: Backdrop(
        frontPanel: Cart(),
        backPanel: _tabBarView,
        frontTitle: Text('Cart'),
        backTitle: Text('SupRest POS'),
      ),
    );
  }
}

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      converter: (Store<AppState> store) => store,
      builder: (context, store) {
        return GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: store.state.products.length,
          itemBuilder: (BuildContext context, int index) {
            final product = store.state.products[index];

            return GestureDetector(
              onTap: () {
                print('clicked');
                return store.dispatch(AddItemAction(product));
              },
              child: Card(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Image.asset(product.imgUrl),
                      Text(product.name),
                      Text(product.price.toString())
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
