import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queromaisvegano/app/models/section.dart';

import '../home_manager.dart';

class AddSectionWidget extends StatelessWidget {
  const AddSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();

    return Row(
      children: [
        Expanded(
          // ignore: deprecated_member_use
          child: FlatButton(
            onPressed: () {
              homeManager.addSection(Section(type: 'List'));
            },
            textColor: Colors.white,
            child: const Text('Adicionar Lista'),
          ),
        ),
        Expanded(
          // ignore: deprecated_member_use
          child: FlatButton(
            onPressed: () {
              homeManager.addSection(Section(type: 'Staggered'));
            },
            textColor: Colors.white,
            child: const Text('Adicionar Grade'),
          ),
        ),
      ],
    );
  }
}
