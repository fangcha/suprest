import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import './ducks/state.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector<AppState, Store<AppState>>(
      converter: (Store<AppState> store) => store,
      builder: (BuildContext context, Store<AppState> store) {
        return ListView.builder(
          itemCount: store.state.cartItems.length,
          itemBuilder: (BuildContext context int index) {
            final cartItems = store.state.cartItems[index];

            return ListTile(
              title: Text(cartItems.name),
              trailing: Text(cartItems.price.toString()),
              

            );
          },
        );
      },
    );
  }
}
