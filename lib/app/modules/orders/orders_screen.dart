import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queromaisvegano/app/common/custom_drawer/custom_drawer.dart';
import 'package:queromaisvegano/app/common/empty_card.dart';
import 'package:queromaisvegano/app/common/login_card.dart';
import 'package:queromaisvegano/app/modules/orders/orders_manager.dart';

import '../../common/order/order_tile.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        centerTitle: true,
      ),
      body: Consumer<OrdersManager>(
        builder: (_, ordersManager, __) {
          if (ordersManager.user == null) {
            return const LoginCard();
          }
          if (ordersManager.orders.isEmpty) {
            return const EmptyCard(
              title: 'Nenhuma compra encontrada!',
              iconData: Icons.border_clear,
            );
          }
          return ListView.builder(
              itemCount: ordersManager.orders.length,
              itemBuilder: (_, index) {
                return OrderTile(
                  ordersManager.orders.reversed.toList()[index],
                );
              });
        },
      ),
    );
  }
}
