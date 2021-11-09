import 'package:flutter/material.dart';
import 'package:queromaisvegano/app/common/custom_drawer/custom_drawer.dart';
import 'package:queromaisvegano/app/helpers/const.dart';
import 'package:provider/provider.dart';
import 'package:queromaisvegano/app/repositories/user_manager.dart';

import 'components/add_section_widget.dart';
import 'components/section_list.dart';
import 'components/section_staggered.dart';
import 'home_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                kMainColorDark,
                kMainColor,
                kMainColor,

                //kMainColorAlpha,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                snap: true,
                elevation: 0,
                floating: true,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.all(8),
                  title: Image.asset(
                    'assets/img/logoa.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                  centerTitle: true,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    color: Colors.white,
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                  ),
                  Consumer2<UserManager, HomeManager>(
                      builder: (_, userManager, homeManager, __) {
                    if (userManager.adminEnabled && !homeManager.loading) {
                      if (homeManager.editing) {
                        return PopupMenuButton(
                          onSelected: (e) {
                            if (e == 'Salvar') {
                              homeManager.saveEditing();
                            } else {
                              homeManager.discardEditing();
                            }
                          },
                          itemBuilder: (_) {
                            return ['Salvar', 'Descartar'].map((e) {
                              return PopupMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList();
                          },
                        );
                      } else {
                        return IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: homeManager.enterEditing,
                        );
                      }
                    } else {
                      return Container();
                    }
                  }),
                ],
              ),
              Consumer<HomeManager>(builder: (_, homeManager, __) {
                if (homeManager.loading) {
                  return const SliverToBoxAdapter(
                    child: LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                      backgroundColor: Colors.transparent,
                    ),
                  );
                }

                final List<Widget> children =
                    homeManager.sections.map<Widget>((section) {
                  switch (section.type) {
                    case 'List':
                      return SectionList(section);
                    case 'Staggered':
                      return SectionStaggered(section);
                    default:
                      return Container();
                  }
                }).toList();

                if (homeManager.editing) children.add(const AddSectionWidget());

                return SliverList(
                  delegate: SliverChildListDelegate(children),
                );
              })
            ],
          ),
        ],
      ),
    );
  }
}
