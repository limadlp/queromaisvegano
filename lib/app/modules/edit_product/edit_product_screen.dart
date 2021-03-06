import 'package:flutter/material.dart';
import 'package:queromaisvegano/app/helpers/const.dart';
import 'package:provider/provider.dart';
import 'package:queromaisvegano/app/models/product.dart';
import 'package:queromaisvegano/app/modules/product/product_manager.dart';

import 'components/images_form.dart';
import 'components/sizes_form.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen(Product? p, {Key? key})
      : editing = p != null,
        product = (p != null ? p.clone() : Product()),
        super(key: key);

  final Product? product;
  final bool editing;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(editing ? 'Editar Produto' : 'Criar Produto'),
          centerTitle: true,
          actions: [
            if (editing)
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Excluir Produto?'),
                      content: const Text('Esta ação não poderá ser desfeita!'),
                      actions: [
                        // ignore: deprecated_member_use
                        FlatButton(
                          onPressed: () {
                            //print('qui');

                            Navigator.of(context).pop();
                          },
                          textColor: Theme.of(context).primaryColor,
                          child: const Text('Cancelar'),
                        ),
                        // ignore: deprecated_member_use
                        FlatButton(
                          onPressed: () {
                            context.read<ProductManager>().delete(product!);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          textColor: Colors.red,
                          child: const Text('Excluir Produto'),
                        ),
                      ],
                    ),
                  );
                },
              )
          ],
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              ImagesForm(product!),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      initialValue: product!.name,
                      decoration: const InputDecoration(
                        hintText: 'Título',
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      validator: (name) {
                        if (name!.length < 6) return 'Título muito curto';
                        return null;
                      },
                      onSaved: (name) => product!.name = name,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'A partir de',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Text(
                      'R\$ ...',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: kMainColor,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        'Descrição',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextFormField(
                      initialValue: product!.description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Descrição',
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                      validator: (desc) {
                        if (desc!.length < 6) {
                          return 'Descrição muito curta.';
                        }
                        return null;
                      },
                      onSaved: (desc) => product!.description = desc,
                    ),
                    SizesForm(
                      product!,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<Product?>(
                      builder: (_, product, __) {
                        return SizedBox(
                          height: 44,
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                            color: kMainColor,
                            disabledColor: kMainColor.withAlpha(100),
                            onPressed: !product!.loading
                                ? () async {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      await product.save();

                                      context
                                          .read<ProductManager>()
                                          .update(product);

                                      Navigator.of(context).pop();
                                    }
                                  }
                                : null,
                            child: product.loading
                                ? const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                      Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Salvar',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18.0),
                                  ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
