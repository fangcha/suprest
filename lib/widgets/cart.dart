import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../ducks/state.dart';
import './cart_item.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      converter: (Store<AppState> store) => store,
      builder: (BuildContext context, Store<AppState> store) {
        int total;
        if (store.state.cartItems.length != 0) {
          total = store.state.cartItems
          .map((product) => product.price)
          .reduce((curr, next) => curr + next);
        } else { total = 0;}
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:<Widget>[ 
            Expanded(
              child: ListView.builder(
                itemExtent: 100.0,
                itemCount: store.state.cartItems.length,
                itemBuilder: (BuildContext context int index) {
                 return CartItem(item: store.state.cartItems[index]);
                },
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Total',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                  ),
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    total.toString(),
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ) 
              ],
            ),
          ]
        );
      },
    );
  }
}
