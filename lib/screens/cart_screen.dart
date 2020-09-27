import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart-screen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '${cart.totalAmount.toStringAsFixed(2)}€',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  _isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : FlatButton(
                          child: Text('ORDER NOW'),
                          onPressed: (cart.totalAmount <= 0.0 || _isLoading)
                              ? null
                              : () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  try {
                                    await Provider.of<Orders>(context,
                                            listen: false)
                                        .addOrder(
                                      cart.items.values.toList(),
                                      cart.totalAmount,
                                    );
                                    cart.clearCart();
                                  } catch (error) {
                                    await showDialog<Null>(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: Text('An error occured'),
                                        content: Text(error.toString()),
                                        actions: [
                                          FlatButton(
                                            child: Text('Okay'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  } finally {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                },
                          textColor: Theme.of(context).primaryColor,
                        )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, i) => CartItem(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].title,
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
