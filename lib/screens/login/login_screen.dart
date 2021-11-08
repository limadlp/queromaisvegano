import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:queromaisvegano/helpers/validators.dart';
import 'package:queromaisvegano/models/user.dart';
import 'package:queromaisvegano/models/user_manager.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Entrar',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            textColor: Colors.white,
            child: Text(
              'CRIAR CONTA',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  padding: EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      controller: emailController,
                      enabled: !userManager.loading,
                      decoration: InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        if (!emailValid(email!)) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: passController,
                      enabled: !userManager.loading,
                      decoration: InputDecoration(hintText: 'Senha'),
                      autocorrect: false,
                      obscureText: true,
                      validator: (pass) {
                        if (pass!.isEmpty || pass.length < 6)
                          return 'Senha inválida';
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        child: Text(
                          'Esqueci minha senha',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: userManager.loading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                userManager.signIn(
                                  user: Usuario(
                                    email: emailController.text,
                                    password: passController.text,
                                  ),
                                  onFail: (e) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        'Falha ao entrar: $e',
                                      ),
                                      backgroundColor: Colors.red,
                                    ));
                                  },
                                  onSuccess: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              }
                            },
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      disabledColor:
                          Theme.of(context).primaryColor.withAlpha(100),
                      child: userManager.loading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : Text(
                              'Entrar',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                    ),
                    /*
                    SignInButton(
                        Buttons.Google,
                        text: 'Entrar com Google',
                        onPressed: (){
                          userManager.facebookLogin();
                        }
                    ),

                     */
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
