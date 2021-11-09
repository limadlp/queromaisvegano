import 'package:flutter/material.dart';
import 'package:queromaisvegano/common/price_card.dart';
import 'package:queromaisvegano/models/cart_manager.dart';
import 'package:queromaisvegano/models/checkout_manager.dart';
import 'package:queromaisvegano/models/credit_card.dart';
import 'package:provider/provider.dart';

import 'components/cpf_field.dart';
import 'components/credit_card_widget.dart';

class CheckoutScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final CreditCard? creditCard = CreditCard();

  CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) =>
          checkoutManager!..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Pagamento'),
            centerTitle: true,
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Consumer<CheckoutManager>(
              builder: (_, checkoutManager, __) {
                if (checkoutManager.loading) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Processando seu pagamento...',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      CreditCardWidget(
                        creditCard,
                      ),
                      const CpfField(),
                      PriceCard(
                        buttonText: 'Finalizar pedido',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            checkoutManager.checkout(
                                creditCard: creditCard,
                                onStockFail: (e) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                      'Produto(s) sem estoque.',
                                    ),
                                    backgroundColor: Colors.red,
                                  ));
                                  Navigator.of(context).popUntil((route) =>
                                      route.settings.name == '/cart');
                                },
                                onPayFail: (e) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('$e'),
                                    backgroundColor: Colors.red,
                                  ));
                                },
                                onSuccess: (order) {
                                  Navigator.of(context).popUntil(
                                      (route) => route.settings.name == '/');
                                  Navigator.of(context).pushNamed(
                                      '/confirmation',
                                      arguments: order);
                                  //context.read<PageManager>().setPage(2);
                                });
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}
