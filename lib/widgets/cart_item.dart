import 'package:flutter/material.dart';
// import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../model/product.dart';
import '../ducks/cart.dart';
import '../ducks/state.dart';

class CartItem extends StatefulWidget {
  final Product product;

  CartItem({this.product});

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    Product product = widget.product;
    return StoreConnector<AppState, onRemoveItem>(
      converter: (store) => (item) => store.dispatch(RemoveItemAction(product)),
      builder: (BuildContext context, callback) {
        return ListTile(
          leading: IconButton(
            onPressed: () => callback(product),
            icon: Icon(Icons.remove_circle_outline),
          ),
          title: StoreConnector<AppState, onUpdateItem>(
            converter: (store) =>
                (id, product) => store.dispatch(UpdateItemAction(id, product)),
            builder: (BuildContext context, callback) {
              return Row(
                children: <Widget>[
                  Expanded(
                    child: Text(product.name,
                        style: Theme.of(context).textTheme.title),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: product.quantity == 0
                        ? () {}
                        : () {
                            callback(
                              product.id,
                              Product(
                                  id: product.id,
                                  name: product.name,
                                  price: product.price,
                                  sku: product.sku,
                                  stock: product.stock,
                                  quantity: product.quantity - 1),
                            );
                          },
                  ),
                  Text(product.quantity.toString()),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      callback(
                        product.id,
                        Product(
                            id: product.id,
                            name: product.name,
                            price: product.price,
                            sku: product.sku,
                            stock: product.stock,
                            quantity: product.quantity + 1),
                      );
                    },
                  )
                ],
              );
            },
          ),
          trailing: Text(
              (widget.product.price * widget.product.quantity).toString(),
              style: Theme.of(context).textTheme.title),
        );
      },
    );
  }
}

typedef onRemoveItem = Function(Product product);
typedef onUpdateItem = Function(String id, Product product);
