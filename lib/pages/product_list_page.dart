import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/category.dart';
import '../widgets/backdrop.dart';
import '../widgets/cart.dart';
import '../model/product.dart';

class ProductListPage extends StatefulWidget {
  final String title;

  ProductListPage({this.title});

  @override
  _ProductListPageState createState() => new _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  static final List<Map<String, dynamic>> _menu = const [
    {'img': 'img1', 'title': 'title1'},
    {'img': 'img2', 'title': 'title2'},
    {'img': 'img3', 'title': 'title3'},
    {'img': 'img4', 'title': 'title4'}
  ];

  static Widget _buildGridView({List<Map<String, dynamic>> gridItem}) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: gridItem.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            print('clicked');
          },
          child: Card(
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(gridItem[index]['title']),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<List<Product>> initialFetchFirestore(String category) async {
    CollectionReference ref =
        Firestore.instance.collection('products/in-stock/$category');
    QuerySnapshot snapshot = await ref.getDocuments();
    List<Product> initialProducts = [];
    int i = 0;
    snapshot.documents.forEach((document) {
      i++;
      initialProducts.add(Product(
          id: '$i',
          name: document['name'],
          price: document['price'],
          quantity: 1,
          stock: document['stock'],
          sku: document['sku']));
    });

    return initialProducts;
  }

  TabBarView tabBarView = TabBarView(
    children: <Widget>[
      Category(initialFetchFirestore('category-1')),
      Category(initialFetchFirestore('category-2')),
      _buildGridView(gridItem: _menu),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Backdrop(
        frontPanel: Cart(),
        backPanel: tabBarView,
        frontTitle: Text('Cart'),
        backTitle: Text('SupRest POS'),
      ),
    );
  }
}
