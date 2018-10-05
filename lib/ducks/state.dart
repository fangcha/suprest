import 'product.dart';

class AppState {
  final List<Product> products;
  final List<Product> cartItems;

  AppState({this.products = const [], this.cartItems = const []});

  factory AppState.initial() => new AppState(
        products: [
          Product(id: '001', name: 'Food', price: 100, imgUrl: 'assets/1.jpg'),
          Product(id: '002', name: 'Vegie', price: 50, imgUrl: 'assets/2.jpg')
        ],
      );
}

AppState rootReducer(AppState state, dynamic action) {
  return AppState(
      products: state.products,
      cartItems: cartReducer(state.cartItems, action));
}
