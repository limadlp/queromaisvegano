import 'package:flutter/material.dart';
import 'package:queromaisvegano/app/helpers/const.dart';
import 'package:provider/provider.dart';
import 'package:queromaisvegano/app/repositories/user_manager.dart';
import 'custom_drawer_header.dart';
import 'drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
      ),
      child: Drawer(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    //Colors.white,
                    //Colors.white,
                    //Colors.white,
                    //kMainColor,
                    //kMainColorDark,
                    //kMainColorDark,
                    kDrawerColor.withOpacity(0.9),
                    kDrawerColor.withOpacity(0.9),
                    //kDrawerColor.withAlpha(220),
                    //kDrawerColor.withAlpha(300),
                    //kDrawerColor,
                    //Colors.white,//kMainColorAlpha2,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            ListView(
              children: [
                const CustomDrawerHeader(),
                const Divider(),
                const DrawerTile(
                  iconData: Icons.home,
                  title: 'Início',
                  page: 0,
                ),
                const DrawerTile(
                  iconData: Icons.list,
                  title: 'Produtos',
                  page: 1,
                ),
                const DrawerTile(
                  iconData: Icons.playlist_add_check,
                  title: 'Meus Pedidos',
                  page: 2,
                ),
                const DrawerTile(
                  iconData: Icons.place,
                  title: 'Lojas',
                  page: 3,
                ),
                Consumer<UserManager>(builder: (_, userManager, __) {
                  if (userManager.adminEnabled) {
                    return Column(
                      children: [
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Admin',
                                style: TextStyle(
                                    color: kSpotLightColor,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        const DrawerTile(
                          iconData: Icons.people,
                          title: 'Usuários',
                          page: 4,
                        ),
                        const DrawerTile(
                          iconData: Icons.all_inbox,
                          title: 'Pedidos',
                          page: 5,
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
