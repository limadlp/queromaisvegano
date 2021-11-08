import 'package:flutter/material.dart';
import 'package:queromaisvegano/common/price_card.dart';
import 'package:queromaisvegano/models/cart_manager.dart';
import 'package:provider/provider.dart';

import 'components/address_card.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrega'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AddressCard(),
          Consumer<CartManager>(
            builder: (_, cartManager, __) {
              return PriceCard(
                buttonText: 'Continuar para o pagamento',
                onPressed: cartManager.isAddressValid!
                    ? () {
                        Navigator.of(context).pushNamed('/checkout');
                      }
                    : null,
              );
            },
          )
        ],
      ),
    );
  }
}
