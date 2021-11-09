import 'package:flutter/material.dart';
import 'package:queromaisvegano/models/order.dart';

import 'cancel_order_dialog.dart';
import 'export_address_dialog.dart';
import 'order_product_tile.dart';

class OrderTile extends StatelessWidget {
  const OrderTile(this.order, {Key? key, this.showControls = false})
      : super(key: key);
  final Order? order;
  final bool showControls;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order!.formattedId,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
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
            Text(
              order!.statusText,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: order!.status == Status.canceled
                    ? Colors.red
                    : primaryColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        children: [
          Column(
            children: order!.items!.map((e) {
              return OrderProductTile(e);
            }).toList(),
          ),
          if (showControls && order!.status != Status.canceled)
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => CancelOrderDialog(order),
                      );
                    },
                    textColor: Colors.red,
                    child: const Text('Cancelar'),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: order!.back,
                    child: const Text('Recuar'),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: order!.advance,
                    child: const Text('Avançar'),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => ExportAddressDialog(order!.address),
                      );
                    },
                    textColor: primaryColor,
                    child: const Text('Endereço'),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
