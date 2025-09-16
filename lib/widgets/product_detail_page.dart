import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_application_2/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(product.image, fit: BoxFit.cover),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
              IconButton(icon: const Icon(Icons.share), onPressed: () {}),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: product.rating,
                        itemBuilder: (context, index) =>
                            const Icon(Icons.star, color: Colors.amber),
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${product.rating} (120 reviews)',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description.isEmpty
                        ? 'This is a high-quality product made from premium materials. It offers great comfort and style for everyday wear. The design is modern and suitable for various occasions.'
                        : product.description,
                    style: const TextStyle(color: Colors.grey, height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Color',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildColorOption(Colors.blue, true),
                      _buildColorOption(Colors.red, false),
                      _buildColorOption(Colors.black, false),
                      _buildColorOption(Colors.green, false),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Size',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildSizeOption('S', false),
                      _buildSizeOption('M', true),
                      _buildSizeOption('L', false),
                      _buildSizeOption('XL', false),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Price',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Product added to cart'),
                              ),
                            );
                          },
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorOption(Color color, bool selected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: selected
            ? Border.all(color: Colors.deepPurple, width: 3)
            : null,
      ),
      child: selected
          ? const Center(
              child: Icon(Icons.check, color: Colors.white, size: 16),
            )
          : null,
    );
  }

  Widget _buildSizeOption(String size, bool selected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: selected ? Colors.deepPurple : Colors.grey.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          size,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}