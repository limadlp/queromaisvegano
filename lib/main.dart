import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:queromaisvegano/models/admin_orders_manager.dart';
import 'package:queromaisvegano/models/admin_users_manager.dart';
import 'package:queromaisvegano/models/stores_manager.dart';
import 'package:queromaisvegano/screens/address/address_screen.dart';
import 'package:queromaisvegano/screens/base/base_screen.dart';
import 'package:queromaisvegano/screens/cart/cart_screen.dart';
import 'package:queromaisvegano/screens/checkout/checkout_screen.dart';
import 'package:queromaisvegano/screens/confirmation/confirmation_screen.dart';
import 'package:queromaisvegano/screens/edit_product/edit_product_screen.dart';
import 'package:queromaisvegano/screens/login/login_screen.dart';
import 'package:queromaisvegano/screens/product/product_screen.dart';
import 'package:queromaisvegano/screens/select_product/select_product_screen.dart';
import 'package:queromaisvegano/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

import 'const.dart';
import 'models/cart_manager.dart';
import 'models/home_manager.dart';
import 'models/order.dart';
import 'models/orders_manager.dart';
import 'models/product.dart';
import 'models/product_manager.dart';
import 'models/user_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => StoresManager(),
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
              cartManager!..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, OrdersManager>(
          create: (_) => OrdersManager(),
          lazy: false,
          update: (_, userManager, ordersManager) =>
              ordersManager!..updateUser(userManager.user),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, adminUsersManager) =>
              adminUsersManager!..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminOrdersManager>(
          create: (_) => AdminOrdersManager(),
          lazy: false,
          update: (_, userManager, adminOrdersManager) => adminOrdersManager!
            ..updateAdmin(adminEnabled: userManager.adminEnabled),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LC MAKEUP',
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
          inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(color: kMainColorAlpha)),
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
      ),
    );
  }
}
