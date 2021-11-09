import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'helpers/const.dart';
import 'models/order.dart';
import 'models/product.dart';
import 'modules/address/address_screen.dart';
import 'modules/auth/login/login_screen.dart';
import 'modules/auth/signup/signup_screen.dart';
import 'modules/base/base_screen.dart';
import 'modules/cart/cart_screen.dart';
import 'modules/checkout/checkout_screen.dart';
import 'modules/confirmation/confirmation_screen.dart';
import 'modules/edit_product/edit_product_screen.dart';
import 'modules/product/product_screen.dart';
import 'modules/select_product/select_product_screen.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QueroMais Vegano',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.grey,
        primaryColor: kMainColor,
        primaryTextTheme: const TextTheme(
          headline6: TextStyle(color: Colors.white),
          caption: TextStyle(color: Colors.white),
        ),
        primaryIconTheme: const IconThemeData.fallback().copyWith(
          color: Colors.white,
        ),
        hintColor: kMainColorAlpha,
        inputDecorationTheme:
            InputDecorationTheme(labelStyle: TextStyle(color: kMainColorAlpha)),
        scaffoldBackgroundColor: kMainColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
            color: kcMainColor,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      //initialRoute: '/base',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/edit_product':
            return MaterialPageRoute(
                builder: (_) =>
                    EditProductScreen(settings.arguments as Product?));
          case '/cart':
            return MaterialPageRoute(
                builder: (_) => const CartScreen(), settings: settings);
          case '/address':
            return MaterialPageRoute(builder: (_) => const AddressScreen());
          case '/checkout':
            return MaterialPageRoute(builder: (_) => CheckoutScreen());
          case '/confirmation':
            return MaterialPageRoute(
                builder: (_) =>
                    ConfirmationScreen(settings.arguments as Order?));
          case '/select_product':
            return MaterialPageRoute(
                builder: (_) => const SelectProductScreen());
          case '/product':
            return MaterialPageRoute(
                builder: (_) => ProductScreen(settings.arguments as Product));
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case '/signup':
            return MaterialPageRoute(builder: (_) => SignUpScreen());
          case '/':
          default:
            return MaterialPageRoute(
                builder: (_) => const BaseScreen(), settings: settings);
        }
      },
    );
  }
}
