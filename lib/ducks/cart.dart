import 'package:redux/redux.dart';

import '../model/product.dart';

abstract class CartAction {}

class LoadItemsAction extends CartAction {
  final List<Product> products;

  LoadItemsAction(this.products);
}

class AddItemAction extends CartAction {
  final Product product;

  AddItemAction(this.product);
}

class UpdateItemAction extends CartAction {
  final String id;
  final Product updatedProduct;

  UpdateItemAction(this.id, this.updatedProduct);
}

class RemoveItemAction extends CartAction {
  final Product product;

  RemoveItemAction(this.product);
}

// combine reducers
final cartReducer = combineReducers<List<Product>>([
  TypedReducer<List<Product>, LoadItemsAction>(loadItemsReducer),
  TypedReducer<List<Product>, AddItemAction>(addItemReducer),
  TypedReducer<List<Product>, UpdateItemAction>(updateItemReducer),
  TypedReducer<List<Product>, RemoveItemAction>(removeItemReducer),
]);

// various reducers for different actions
List<Product> loadItemsReducer(List<Product> state, LoadItemsAction action) {
  return action.products;
}

List<Product> addItemReducer(List<Product> state, AddItemAction action) {
  List<Product> newState;
  List<String> id = state.map((product) => product.id).toList();
  print('state $state');

  if (id.contains(action.product.id)) {
    print('if');
    print(action.product.id);
    newState = state.map((product) {
      if (product.id == action.product.id) {
        print(
            'product.id=${product.id} == action.product.id=${action.product.id}');
        return Product(
            id: product.id,
            name: product.name,
            sku: product.sku,
            price: product.price,
            stock: product.stock,
            quantity: product.quantity + 1);
      } else {
        print('action.product.${action.product.name}');
        return product;
      }
    }).toList();
  } else {
    print('else');
    newState = List.from(state)..add(action.product);
  }
  print('newState ${newState.length}');
  return newState;
}

List<Product> updateItemReducer(List<Product> state, UpdateItemAction action) {
  return state
      .map((product) =>
          product.id == action.id ? action.updatedProduct : product)
      .toList();
}

List<Product> removeItemReducer(List<Product> state, RemoveItemAction action) {
  return List.from(state)..remove(action.product);
}
