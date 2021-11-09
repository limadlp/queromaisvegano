import 'package:flutter/material.dart';
import 'package:queromaisvegano/app/helpers/const.dart';
import 'package:provider/provider.dart';
import 'package:queromaisvegano/app/modules/cart/cart_manager.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({Key? key, this.buttonText, this.onPressed})
      : super(key: key);

  final String? buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final productsPrice = cartManager.productsPrice;
    final deliveryPrice = cartManager.deliveryPrice;
    final totalPrice = cartManager.totalPrice;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Resumo do Pedido',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal'),
                Text(
                    'R\$ ${productsPrice.toStringAsFixed(2).replaceAll('.', ',')}'),
              ],
            ),
            const Divider(),
            if (deliveryPrice != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Entrega'),
                  Text(
                      'R\$ ${deliveryPrice.toStringAsFixed(2).replaceAll('.', ',')}'),
                ],
              ),
              const Divider(),
            ],
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  'R\$ ${totalPrice.toStringAsFixed(2).replaceAll('.', ',')}',
                  style: TextStyle(
                    color: kMainColor,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              color: kMainColor,
              disabledColor: Theme.of(context).primaryColor.withAlpha(100),
              textColor: Colors.white,
              onPressed: onPressed,
              child: Text(buttonText!),
            ),
          ],
        ),
      ),
    );
  }
}
