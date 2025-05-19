import 'package:deels_here/core/themes/app_colors.dart';
import 'package:deels_here/domain/models/cart_item_model.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onRemove;

  const CartItemWidget({Key? key, required this.item, required this.onRemove})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.fieldBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Placeholder for image
            Container(
              width: 80,
              height: 80,
              color: Colors.grey[300],
              margin: const EdgeInsets.only(right: 16.0),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 20),
                        onPressed: onRemove,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Size: ${item.size}'),
                      const SizedBox(width: 16),
                      Text('Color: '),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _getColorForItem(item.name),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text('Qty: ${item.quantity}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${item.price.toInt()} DA',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForItem(String name) {
    // Dummy colors based on the image
    switch (name.toLowerCase()) {
      case 'standard fit pants':
        return Colors.blue[900]!;
      case 'oversized t-shirt':
        return Colors.yellow[100]!;
      case 'denim jacket':
        return Colors.pink[200]!;
      case 'spring sport wear':
        return Colors.grey[300]!;
      default:
        return Colors.grey;
    }
  }
}
