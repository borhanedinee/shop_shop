// ----------------- presentation/views/product_detail_screen.dart -----------------
import 'package:deels_here/domain/models/cart_item_model.dart';
import 'package:deels_here/domain/models/product_model.dart';
import 'package:deels_here/presentation/controller/cart_controller.dart';
import 'package:deels_here/presentation/screens/login_screen.dart';
import 'package:deels_here/presentation/screens/seller_details_screen.dart';
import 'package:deels_here/presentation/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final Map<String, Color> colorMap = {
  "Black": Colors.black,
  "White": Colors.white,
  "Blue": Colors.blue,
};

class ProductDetailScreen extends StatefulWidget {
  final ProductModel item;

  const ProductDetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String selectedSize = '';
  String selectedColor = '';
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
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
                          height: 350,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              widget.item.avatar,
                              fit: BoxFit.cover,
                            ),
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
                        Text(
                          widget.item.description,
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Item Size',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                widget.item.sizes
                                    .map(
                                      (size) => Padding(
                                        padding: const EdgeInsets.only(
                                          right: 8.0,
                                        ),
                                        child: ChoiceChip(
                                          selected: selectedSize == size,
                                          label: Text(size),
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
                        ),

                        const SizedBox(height: 16),
                        const Text(
                          'Seller',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () {
                            // navigate to seller details screen
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (context) => SellerDetailsScreen(
                                      sellerName: widget.item.sellerName,
                                    ),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              // avatar
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: Image.asset(
                                  'assets/images/seller-avatar.png',
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                widget.item.sellerName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),
                        if (widget.item.colors != null &&
                            widget.item.colors!.isNotEmpty) ...[
                          const Text(
                            'Item Color',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children:
                                widget.item.colors
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
                                              color:
                                                  colorMap[color] ??
                                                  Colors.grey,
                                              border: Border.all(
                                                color:
                                                    selectedColor == color
                                                        ? Colors.grey
                                                        : Colors.transparent,
                                                width: 3,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ],
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text('Count'),
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
                                    if (quantity < widget.item.stock) {
                                      setState(() {
                                        quantity++;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                            Text(
                              '${widget.item.price.toInt() * quantity} DA',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                  GetBuilder<CartController>(
                    builder:
                        (controller) => Positioned(
                          bottom: 16,
                          left: 16,
                          right: 16,
                          child: SizedBox(
                            width: double.infinity,
                            child: MyButton(
                              onPressed: () {
                                if (isGuest) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                    ),
                                    (route) => false,
                                  );
                                } else {
                                  if (widget.item.sizes.isNotEmpty &&
                                      selectedSize.isEmpty) {
                                    Get.showSnackbar(
                                      GetSnackBar(
                                        title: 'Error',
                                        message: 'Please select size ',
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                    return;
                                  }
                                  if (widget.item.colors.isNotEmpty &&
                                      selectedColor.isEmpty) {
                                    Get.showSnackbar(
                                      GetSnackBar(
                                        title: 'Error',
                                        message: 'Please select size ',
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                    return;
                                  }

                                  final cartItemID =
                                      DateTime.now().millisecondsSinceEpoch
                                          .toString();

                                  controller.addToCart(
                                    CartItem(
                                      cartItemId: cartItemID,
                                      name: widget.item.name,
                                      avatar: widget.item.avatar,
                                      price:
                                          widget.item.price.toInt() * quantity,
                                      size: selectedSize,
                                      color: selectedColor,
                                      quantity: quantity,
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                controller.isAddingToCart
                                    ? 'Adding to cart...'
                                    : isGuest
                                    ? 'Start Now'
                                    : 'Add to cart',
                                style: TextStyle(color: Colors.white),
                              ),
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
