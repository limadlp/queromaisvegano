import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:queromaisvegano/app/helpers/const.dart';
import 'package:queromaisvegano/app/models/address.dart';
import 'package:screenshot/screenshot.dart';

class ExportAddressDialog extends StatelessWidget {
  ExportAddressDialog(this.address, {Key? key}) : super(key: key);
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
        // ignore: deprecated_member_use
        FlatButton(
          textColor: Theme.of(context).primaryColor,
          onPressed: () async {
            Navigator.of(context).pop();
            await screenshotController.capture().then((Uint8List? image) async {
              await ImageGallerySaver.saveImage(image!);
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text(
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
