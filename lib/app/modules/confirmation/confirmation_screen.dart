import 'package:flutter/material.dart';
import 'package:queromaisvegano/app/common/order/order_product_tile.dart';
import 'package:queromaisvegano/app/models/order.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen(this.order, {Key? key}) : super(key: key);
  final Order? order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pedido Confirmado'),
          centerTitle: true,
        ),
        body: Center(
          child: Card(
            margin: const EdgeInsets.all(16),
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order!.formattedId,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        'R\$ ${order!.price!.toStringAsFixed(2).replaceAll('.', ',')}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: order!.items!.map((e) {
                    return OrderProductTile(e);
                  }).toList(),
                ),
              ],
            ),
          ),
        ));
  }
}
