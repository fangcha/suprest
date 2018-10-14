import 'package:flutter/material.dart';
// import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../ducks/product.dart';
import '../ducks/state.dart';

class CartItem extends StatefulWidget {
  final Product item;

  CartItem({Key key, this.item}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, onRemoveItem>(
      converter: (store) =>
          (item) => store.dispatch(RemoveItemAction(widget.item)),
      builder: (BuildContext context, callback) {
        return Dismissible(
          key: Key(widget.item.name),
          onDismissed: (direction) {
            setState(() => callback(widget.item.name));
          },
          child: ListTile(
            title: Text(widget.item.name),
            leading: Icon(Icons.remove_circle_outline),
            trailing: Text(widget.item.price.toString()),
          ),
        );
      },
    );
  }
}

typedef onRemoveItem = Function(String item);
