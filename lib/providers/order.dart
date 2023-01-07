import 'package:flutter/foundation.dart';
import 'package:shop_app_provider/providers/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse( 'https://shopapp-d683e-default-rtdb.firebaseio.com/orders.json');
    try {
      final response = await http.get(url);
      final List<OrderItem> loadedOrders = [];
      final extractedData = json.decode(response.body) ??
          // ignore: unnecessary_cast
          <String, dynamic>{} as Map<String, dynamic>;

      if (extractedData == <String, dynamic>{}) {
        return;
      }

      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(OrderItem(
            id: orderId,
            amount: orderData['amount'],
            dateTime: DateTime.parse(orderData['dateTime']),
            products: (orderData['products'] as List<dynamic>)
                .map((item) => CartItem(
              id: item['id'],
              price: item['price'],
              quantity: item['quantity'],
              title: item['title'],
            ))
                .toList()));
      });

      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse( 'https://shopapp-d683e-default-rtdb.firebaseio.com/orders.json');
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
          'id': cp.id,
          'title': cp.title,
          'quantity': cp.quantity,
          'price': cp.price,
        })
            .toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timestamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
