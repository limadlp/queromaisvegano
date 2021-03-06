import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:queromaisvegano/app/models/page_manager.dart';
import 'package:queromaisvegano/app/modules/admin_orders/admin_orders_screen.dart';
import 'package:queromaisvegano/app/modules/admin_users/admin_users_screen.dart';
import 'package:queromaisvegano/app/modules/home/home_screen.dart';
import 'package:queromaisvegano/app/modules/orders/orders_screen.dart';
import 'package:queromaisvegano/app/modules/products/products_screen.dart';
import 'package:queromaisvegano/app/modules/stores/stores_screen.dart';
import 'package:queromaisvegano/app/repositories/user_manager.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    //configFCM();
  }

  void configFCM() {
    final fcm = FirebaseMessaging.instance;
    if (Platform.isIOS) {
      fcm.requestPermission(
        provisional: true,
      );
    }

    /*
      fcm.configure(
          onLaunch: (Map<String, dynamic> message) async {
            print('onLaunch $message');
          },
          onResume: (Map<String, dynamic> message) async {
            print('onResume $message');
          },
          onMessage: (Map<String, dynamic> message) async {
            showNotification(
              message['notification']['title'] as String,
              message['notification']['body'] as String,
            );
          }
      );

       */
  }

  void showNotification(String title, String message) {
    Flushbar(
      title: title,
      message: message,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      isDismissible: true,
      backgroundColor: Theme.of(context).primaryColor,
      duration: const Duration(seconds: 5),
      icon: const Icon(
        Icons.shopping_cart,
        color: Colors.white,
      ),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(builder: (_, userManager, __) {
        return PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const HomeScreen(),
            const ProductsScreen(),
            const OrdersScreen(),
            const StoresScreen(),
            if (userManager.adminEnabled) ...[
              const AdminUsersScreen(),
              const AdminOrdersScreen(),
            ]
          ],
        );
      }),
    );
  }
}
