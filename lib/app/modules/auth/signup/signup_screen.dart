import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queromaisvegano/app/helpers/validators.dart';
import 'package:queromaisvegano/app/models/user.dart';
import 'package:queromaisvegano/app/repositories/user_manager.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Usuario user = Usuario();

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Criar Conta',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(builder: (_, userManager, __) {
              return ListView(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                children: [
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: 'Nome Completo'),
                    enabled: !userManager.loading,
                    validator: (name) {
                      if (name!.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (name.trim().split(' ').length <= 1) {
                        return 'Preencha seu nome completo';
                      }
                      return null;
                    },
                    onSaved: (name) => user.name = name,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    enabled: !userManager.loading,
                    decoration: const InputDecoration(hintText: 'E-mail'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email!.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (!emailValid(email)) {
                        return 'E-mail inválido';
                      }
                      return null;
                    },
                    onSaved: (email) => user.email = email!,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    enabled: !userManager.loading,
                    decoration: const InputDecoration(hintText: 'Senha'),
                    obscureText: true,
                    validator: (pass) {
                      if (pass!.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (pass.length < 6) {
                        return 'Senha muito curta';
                      }
                      return null;
                    },
                    onSaved: (pass) {
                      user.password = pass!;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    enabled: !userManager.loading,
                    decoration:
                        const InputDecoration(hintText: 'Repita a Senha'),
                    obscureText: true,
                    validator: (pass) {
                      if (pass!.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (pass.length < 6) {
                        return 'Senha muito curta';
                      }
                      return null;
                    },
                    onSaved: (pass) {
                      user.confirmPassword = pass;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    disabledColor:
                        Theme.of(context).primaryColor.withAlpha(100),
                    onPressed: userManager.loading
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();

                              if (user.password != user.confirmPassword) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                    'Senhas não coincidem',
                                  ),
                                  backgroundColor: Colors.red,
                                ));
                                return;
                              }
                              context.read<UserManager>().signUp(
                                    user: user,
                                    onSuccess: () {
                                      Navigator.of(context).pop();
                                    },
                                    onFail: (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          'Falha ao cadastrar: $e',
                                        ),
                                        backgroundColor: Colors.red,
                                      ));
                                    },
                                  );
                            }
                          },
                    child: userManager.loading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                              Colors.white,
                            ),
                          )
                        : const Text(
                            'Criar Conta',
                            style: TextStyle(fontSize: 15),
                          ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
