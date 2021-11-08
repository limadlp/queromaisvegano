import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:queromaisvegano/const.dart';
import 'package:queromaisvegano/models/address.dart';
import 'package:screenshot/screenshot.dart';

class ExportAddressDialog extends StatelessWidget {
  ExportAddressDialog(this.address);
  final Address? address;

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Endereço de Entrega'),
      content: Screenshot(
        controller: screenshotController,
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.white,
          child: Text(
            '${address!.street}, ${address!.number} ${address!.complement}\n'
            '${address!.district}\n'
            '${address!.city}/${address!.state}\n'
            '${address!.zipCode}',
          ),
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
      actions: [
        FlatButton(
          textColor: Theme.of(context).primaryColor,
          onPressed: () async {
            Navigator.of(context).pop();
            final file = await screenshotController
                .capture()
                .then((Uint8List? image) async {
              await ImageGallerySaver.saveImage(image!);
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'Imagem salva na galeria.',
              ),
              backgroundColor: kMainColorDark,
            ));
          },
          child: const Text('Exportar'),
        )
      ],
    );
  }
}
