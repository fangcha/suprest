import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import './ducks/state.dart';
import './pages/product_list_page.dart';

void main() {
  final store = Store<AppState>(
    rootReducer,
    initialState: AppState.initial(),
  );
  runApp(App(store: store));
}

class App extends StatelessWidget {
  final Store<AppState> store;

  App({this.store});
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: ProductListPage(title: 'SupRest POS'),
      ),
    );
  }
}
