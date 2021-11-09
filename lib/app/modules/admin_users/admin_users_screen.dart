import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queromaisvegano/app/common/custom_drawer/custom_drawer.dart';
import 'package:queromaisvegano/app/models/page_manager.dart';
import 'package:queromaisvegano/app/modules/admin_orders/admin_orders_manager.dart';

import 'admin_users_manager.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          title: const Text('Usuários'),
          centerTitle: true,
        ),
        body: Consumer<AdminUsersManager>(builder: (_, adminUsersManager, __) {
          //return AlphabetScrowView(
          return AlphabetListScrollView(
            showPreview: true,
            keyboardUsage: true,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(
                  adminUsersManager.users![index].name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  adminUsersManager.users![index].email!,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  context
                      .read<AdminOrdersManager>()
                      .setUserFilter(adminUsersManager.users![index]);
                  context.read<PageManager>().setPage(6);
                },
              );
            },
            strList: adminUsersManager.names ?? [],
            indexedHeight: (index) {
              return 80;
            },
            highlightTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          );
        }));
  }
}
