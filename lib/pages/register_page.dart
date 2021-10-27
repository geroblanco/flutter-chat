import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(titulo: 'Registro'),
                  _Form(),
                  Labels(
                    ruta: 'login',
                    text1: '¿Ya tienes cuenta?',
                    text2: 'Inicia Sesión',
                  ),
                  Text(
                    'Terminos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            CustomInput(
              icon: Icons.perm_identity,
              placeholder: 'Nombre',
              textController: nameCtrl,
              keyboardType: TextInputType.text,
              isPassword: false,
            ),

            CustomInput(
                icon: Icons.mail_outline,
                placeholder: 'Email',
                textController: emailCtrl,
                keyboardType: TextInputType.emailAddress),
            CustomInput(
              icon: Icons.lock_outline,
              placeholder: 'password',
              textController: passCtrl,
              keyboardType: TextInputType.visiblePassword,
              isPassword: true,
            ),
            // CustomInput()

            BotonAzul(
              text: 'Registrarme',
              onPressed: () {
                print(emailCtrl.text);
                print(passCtrl.text);
              },
            ),
          ],
        ));
  }
}
