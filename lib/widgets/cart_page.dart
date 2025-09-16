import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/cart_item.dart';
import 'package:flutter_application_2/models/product.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<CartItem> _cartItems = [
    CartItem(
      product: Product(
        id: '1',
        name: 'Summer T-Shirt',
        price: 29.99,
        image: 'assets/images/tshirt.jpg',
        rating: 4.5,
        description: 'Comfortable cotton t-shirt for summer',
      ),
      quantity: 2,
      size: 'M',
      color: Colors.blue,
    ),
    CartItem(
      product: Product(
        id: '2',
        name: 'Denim Jeans',
        price: 49.99,
        image: 'assets/images/jeans.jpg',
        rating: 4.2,
        description: 'Classic blue denim jeans',
      ),
      quantity: 1,
      size: 'L',
      color: Colors.grey,
    ),
    CartItem(
      product: Product(
        id: '3',
        name: 'Jubah Calle',
        price: 69.99,
        image: 'assets/images/Jubah.jpeg',
        rating: 4.2,
        description: '',
      ),
      quantity: 1,
      size: 'XL',
      color: Colors.grey,
    ),
    CartItem(
      product: Product(
        id: '6',
        name: 'Jubah Zaafer',
        price: 49.99,
        image: 'assets/images/Zaafer.jpeg',
        rating: 4.2,
        description: '',
      ),
      quantity: 1,
      size: 'L',
      color: Colors.grey,
    ),
    CartItem(
      product: Product(
        id: '7',
        name: 'Sepatu Salomon',
        price: 100.99,
        image: 'assets/images/Salomon.jpeg',
        rating: 4.2,
        description: '',
      ),
      quantity: 1,
      size: '42/40',
      color: const Color.fromARGB(255, 168, 159, 159),
    ),
  ];

  double get totalPrice => _cartItems.fold(
        0,
        (sum, item) => sum + item.product.price * item.quantity,
      );

  String _promoCode = '';
  double _discount = 0.0;
  final _promoController = TextEditingController();

  void _applyPromoCode() {
    setState(() {
      final input = _promoController.text.trim().toUpperCase();
      if (input == 'DISKON10') {
        _discount = totalPrice * 0.10;
        _promoCode = input;
      } else {
        _discount = 0.0;
        _promoCode = '';
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Promo code tidak valid')),
        );
      }
    });
  }

  double get finalTotal => totalPrice - _discount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final item = _cartItems[index];
                return ListTile(
                  leading: Image.asset(item.product.image, width: 60, height: 60),
                  title: Text(item.product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Size: ${item.size}'),
                      Text('Price: \$${item.product.price.toStringAsFixed(2)}'),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (item.quantity > 1) item.quantity--;
                              });
                            },
                          ),
                          Text(item.quantity.toString()),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                item.quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _cartItems.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _promoController,
                  decoration: InputDecoration(
                    labelText: 'Enter promo code',
                    suffixIcon: TextButton(
                      onPressed: _applyPromoCode,
                      child: const Text('Apply'),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                if (_discount > 0) ...[
                  const SizedBox(height: 10),
                  Text(
                    'Promo "$_promoCode" applied - You saved \$${_discount.toStringAsFixed(2)}!',
                    style: const TextStyle(color: Colors.green),
                  ),
                ],
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total:', style: TextStyle(fontSize: 18)),
                    Text(
                      '\$${finalTotal.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: () {
                    // Checkout
                  },
                  child: const Text('Checkout'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
