import 'package:flutter/material.dart';
import 'package:queromaisvegano/common/custom_drawer/custom_drawer_header.dart';
import 'package:queromaisvegano/const.dart';
import 'package:queromaisvegano/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
      ),
      child: Drawer(
        child: Container(
          //color: kMainColor,
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
                  CustomDrawerHeader(),
                  const Divider(),
                  DrawerTile(
                    iconData: Icons.home,
                    title: 'Início',
                    page: 0,
                  ),
                  DrawerTile(
                    iconData: Icons.list,
                    title: 'Produtos',
                    page: 1,
                  ),
                  DrawerTile(
                    iconData: Icons.playlist_add_check,
                    title: 'Meus Pedidos',
                    page: 2,
                  ),
                  DrawerTile(
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
                          DrawerTile(
                            iconData: Icons.people,
                            title: 'Usuários',
                            page: 4,
                          ),
                          DrawerTile(
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
      ),
    );
  }
}
