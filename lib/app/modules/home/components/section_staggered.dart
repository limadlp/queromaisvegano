import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:queromaisvegano/app/models/section.dart';
import 'package:queromaisvegano/app/modules/home/components/section_header.dart';

import '../home_manager.dart';
import 'add_tile_widget.dart';
import 'item_tile.dart';

class SectionStaggered extends StatelessWidget {
  final Section section;
  const SectionStaggered(this.section, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();

    return ChangeNotifierProvider.value(
      value: section,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(),
            Consumer<Section>(
              builder: (_, section, __) {
                return StaggeredGridView.countBuilder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  itemCount: homeManager.editing
                      ? section.items!.length + 1
                      : section.items!.length,
                  itemBuilder: (_, index) {
                    if (index < section.items!.length) {
                      return ItemTile(
                        section.items![index],
                      );
                    } else {
                      return const AddTileWidget();
                    }
                  },
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.count(2, index.isEven ? 2 : 1);
                  },
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
