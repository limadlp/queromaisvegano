import 'package:flutter/material.dart';
import 'package:queromaisvegano/common/empty_card.dart';
import 'package:queromaisvegano/common/login_card.dart';
import 'package:queromaisvegano/common/price_card.dart';
import 'package:queromaisvegano/models/cart_manager.dart';
import 'package:provider/provider.dart';

import 'components/cart_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(builder: (_, cartManager, __) {
        if (cartManager.user == null) {
          return LoginCard();
        }

        if (cartManager.items.isEmpty) {
          return EmptyCard(
            iconData: Icons.remove_shopping_cart,
            title: 'Nenhum produto no carrinho!',
          );
        }

        return ListView(
          children: [
            Column(
              children: cartManager.items
                  .map((cartProduct) => CartTile(cartProduct))
                  .toList(),
            ),
            PriceCard(
              buttonText: 'Continuar para Entrega',
              onPressed: cartManager.isCartValid!
                  ? () {
                      Navigator.of(context).pushNamed('/address');
                    }
                  : null,
            ),
          ],
        );
      }),
    );
  }
}
