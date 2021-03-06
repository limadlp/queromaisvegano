import 'package:flutter/material.dart';
import 'package:queromaisvegano/app/helpers/const.dart';
import 'package:provider/provider.dart';
import 'package:queromaisvegano/app/models/item_size.dart';
import 'package:queromaisvegano/app/models/product.dart';

class SizeWidget extends StatelessWidget {
  const SizeWidget({Key? key, required this.size}) : super(key: key);
  final ItemSize size;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final selected = size == product.selectedSize;

    Color color;
    if (!size.hasStock) {
      color = Colors.red.withAlpha(40);
    } else if (selected) {
      color = kMainColorDark;
    } else {
      color = Colors.grey.shade400;
    }

    return GestureDetector(
      onTap: () {
        if (size.hasStock) {
          product.selectedSize = size;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: color,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                size.name!,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'R\$ ${size.price!.toStringAsFixed(2).replaceAll('.', ',')}',
                style: TextStyle(
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
