import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queromaisvegano/app/common/custom_drawer/custom_drawer.dart';
import 'package:queromaisvegano/app/modules/stores/stores_manager.dart';

import 'components/store_card.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Lojas'),
        centerTitle: true,
      ),
      body: Consumer<StoresManager>(builder: (_, storesManager, __) {
        if (storesManager.stores!.isEmpty) {
          return const LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
            backgroundColor: Colors.transparent,
          );
        }
        return ListView.builder(
          itemCount: storesManager.stores!.length,
          itemBuilder: (_, index) {
            return StoreCard(storesManager.stores![index]);
          },
        );
      }),
    );
  }
}
