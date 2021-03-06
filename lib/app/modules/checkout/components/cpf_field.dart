import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:queromaisvegano/app/repositories/user_manager.dart';

class CpfField extends StatelessWidget {
  const CpfField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userManager = context.watch<UserManager>();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CPF',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            TextFormField(
              // ignore: unnecessary_null_in_if_null_operators
              initialValue: userManager.user!.cpf ?? null,
              decoration: const InputDecoration(
                hintText: '000.000.000-00',
                isDense: true,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CpfInputFormatter(),
              ],
              validator: (cpf) {
                if (cpf!.isEmpty) {
                  return 'Campo Obrigatório';
                } else if (!CPFValidator.isValid(cpf)) {
                  return 'CPF Inválido';
                }
                return null;
              },
              onSaved: userManager.user!.setCpf,
            ),
          ],
        ),
      ),
    );
  }
}
