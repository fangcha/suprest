import 'product.dart';

class AppState {
  final List<Product> products;
  final List<Product> cartItems;

  AppState({this.products = const [], this.cartItems = const []});

  factory AppState.initial() {
    return AppState(products: [], cartItems: []);
  }
}

AppState rootReducer(AppState state, dynamic action) {
  return AppState(
      products: state.products,
      cartItems: cartReducer(state.cartItems, action));
}
