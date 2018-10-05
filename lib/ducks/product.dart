import 'package:redux/redux.dart';

// import 'state.dart';

class Product {
  final String id;
  final String name;
  final String imgUrl;
  final int price;

  Product({this.id, this.name, this.imgUrl, this.price});
}

abstract class ProductAction {}

class LoadItemsAction extends ProductAction {}

class AddItemAction extends ProductAction {
  final Product product;

  AddItemAction(this.product);
}

class UpdateItemAction extends ProductAction {}

class RemoveItemAction extends ProductAction {
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
  return state;
}

List<Product> addItemReducer(List<Product> state, AddItemAction action) {
  return List.from(state)..add(action.product);
}

List<Product> updateItemReducer(List<Product> state, UpdateItemAction action) {
  return state;
}

List<Product> removeItemReducer(List<Product> state, RemoveItemAction action) {
  return state;
}
