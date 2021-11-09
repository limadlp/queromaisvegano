import 'dart:io';

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queromaisvegano/app/helpers/const.dart';
import 'package:queromaisvegano/app/models/product.dart';

import 'image_source_sheet.dart';

class ImagesForm extends StatelessWidget {
  const ImagesForm(this.product, {Key? key}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: List.from(product.images!),
      validator: (images) {
        if (images!.isEmpty) return 'Insira ao menos uma imagem';
        return null;
      },
      onSaved: (images) => product.newImages = images,
      builder: (state) {
        void onImageSelected(File file) {
          state.value!.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }

        return Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                images: state.value!.map<Widget>((image) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      if (image is String)
                        Image.network(
                          image,
                          fit: BoxFit.cover,
                        )
                      else
                        Image.file(
                          image as File,
                          fit: BoxFit.cover,
                        ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.remove),
                          color: Colors.red,
                          onPressed: () {
                            state.value!.remove(image);
                            state.didChange(state.value);
                          },
                        ),
                      )
                    ],
                  );
                }).toList()
                  ..add(Material(
                    color: Colors.grey[100],
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo),
                      iconSize: 50,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (Platform.isAndroid) {
                          showModalBottomSheet(
                              context: context,
                              builder: (_) => ImageSourceSheet(
                                    onImageSelected: onImageSelected,
                                  ));
                        } else if (Platform.isIOS) {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (_) => ImageSourceSheet(
                                    onImageSelected: onImageSelected,
                                  ));
                        }
                      },
                    ),
                  )),
                dotSize: 4,
                dotBgColor: Colors.transparent,
                dotColor: kMainColor,
                autoplay: false,
                dotSpacing: 15,
              ),
            ),
            if (state.hasError)
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 16, left: 16),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
