// ----------------- presentation/views/product_detail_screen.dart -----------------
import 'package:deels_here/domain/models/cart_item_model.dart';
import 'package:deels_here/presentation/controller/cart_controller.dart';
import 'package:deels_here/presentation/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatefulWidget {
  final CartItemModel item;

  const ProductDetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String selectedSize = 'XL'; // Default size
  Color selectedColor = Colors.grey; // Default color (gray from image)
  int quantity = 2; // Default quantity from image

  final List<String> sizes = ['S', 'M', 'L', 'XL'];
  final List<Color> colors = [
    Colors.black,
    Colors.blue[900]!,
    Colors.yellow[100]!,
    Colors.grey,
    Colors.pink[200]!,
    Colors.green[900]!,
  ];

  double get totalPrice => widget.item.price * quantity;

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
        ],
      ),
      body: LayoutBuilder(
        builder:
            (context, constraints) => Container(
              height: constraints.maxHeight,
              margin: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(16),
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.item.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 20,
                                ),
                                SizedBox(width: 4),
                                Text('4.5'),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed diam nonummy',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Item Size',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children:
                              sizes
                                  .map(
                                    (size) => Padding(
                                      padding: const EdgeInsets.only(
                                        right: 8.0,
                                      ),
                                      child: ChoiceChip(
                                        label: Text(size),
                                        selected: selectedSize == size,
                                        onSelected: (selected) {
                                          if (selected) {
                                            setState(() {
                                              selectedSize = size;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Item Color',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children:
                              colors
                                  .map(
                                    (color) => Padding(
                                      padding: const EdgeInsets.only(
                                        right: 8.0,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedColor = color;
                                          });
                                        },
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: color,
                                            border: Border.all(
                                              color:
                                                  selectedColor == color
                                                      ? Colors.black
                                                      : Colors.transparent,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text('Qty'),
                                const SizedBox(width: 16),
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    if (quantity > 1) {
                                      setState(() {
                                        quantity--;
                                      });
                                    }
                                  },
                                ),
                                Text('$quantity'),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      quantity++;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Text(
                              'TOTAL \$${totalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: SizedBox(
                      width: double.infinity,
                      child: MyButton(
                        onPressed: () {
                          // Create a new CartItemModel with updated size and quantity
                          final updatedItem = CartItemModel(
                            id: widget.item.id,
                            name: widget.item.name,
                            size: selectedSize,
                            quantity: quantity,
                            price: widget.item.price,
                          );
                          // cartController.addToCart(updatedItem);
                          Get.snackbar(
                            'Success',
                            '${widget.item.name} added to cart',
                          );
                        },
                        child: const Text(
                          'Add to cart',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
