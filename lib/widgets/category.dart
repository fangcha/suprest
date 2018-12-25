import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:async';

import '../ducks/state.dart';
import '../ducks/cart.dart';
import '../model/product.dart';

class Category extends StatelessWidget {
  final Future<List<Product>> products;

  Category(this.products);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      converter: (Store<AppState> store) => store,
      builder: (BuildContext context, Store<AppState> store) {
        return FutureBuilder<List<Product>>(
          future: products,
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = snapshot.data[index];
                  return GestureDetector(
                    onTap: () {
                      // Scaffold.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('Added to Cart!'),
                      //   ),
                      // );
                      return store.dispatch(AddItemAction(product));
                    },
                    child: Card(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Center(
                                child: Text(
                                  '${product.name} ${product.id}',
                                  style: Theme.of(context).textTheme.display3,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                product.price.toString(),
                                style: Theme.of(context).textTheme.display2,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }
}
