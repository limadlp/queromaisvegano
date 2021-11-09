import 'package:flutter/material.dart';
import 'package:queromaisvegano/const.dart';
import 'package:queromaisvegano/models/page_manager.dart';
import 'package:queromaisvegano/models/user_manager.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
        height: 180,
        child: Consumer<UserManager>(
          builder: (_, userManager, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'assets/img/logo3.png',
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Olá, ${userManager.user?.name ?? ''}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kSpotLightColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (userManager.isLoggedIn) {
                      context.read<PageManager>().setPage(0);
                      userManager.signOut();
                    } else {
                      Navigator.of(context).pushNamed('/login');
                    }
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      userManager.isLoggedIn
                          ? 'Sair'
                          : 'Entre ou cadastre-se >',
                      style: TextStyle(
                        color: kIconColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
