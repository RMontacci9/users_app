
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_app/splash_screen/splash_screen.dart';

import '../global/global.dart';
import '../widgets/progress_dialog.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();


  validateForm(){
    if(nameTextEditingController.text.length < 3){
      Fluttertoast.showToast(msg: 'O nome deve ter mais de 3 caracteres');
    }
    else if(!emailTextEditingController.text.contains('@')){
      Fluttertoast.showToast(msg: 'O endereço de email não é válido.');
    }
    else if(phoneTextEditingController.text.isEmpty){
      Fluttertoast.showToast(msg: 'O número de telefone é obrigatório.');
    }
    else if(passwordTextEditingController.text.length < 6){
      Fluttertoast.showToast(msg: 'a senha deve ter mais de 6 caracteres. ');
    }
    else {
      saveUserInfoNow();
    }
  }

  saveUserInfoNow() async{

    //A função começa mostrando um diálogo de progresso usando showDialog(), exibindo uma mensagem indicando que o processo está em andamento.

    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
      return ProgressDialog(message: 'Processando, por favor aguarde...',);
    });
    //O método trim() é usado em strings para remover os espaços em branco (espaços, tabulações e quebras de linha) no início e no final da string.

    //Depois do trim() é feito o uso do createUserWithEmailAndPassword() do objeto fAuth (que provavelmente é uma instância de FirebaseAuth)
    // para criar um novo usuário no Firebase usando o email e a senha fornecidos. Esse método retorna uma UserCredential,
    // que contém informações sobre o usuário recém-criado.

    final User? firebaseUser = (
        await fAuth.createUserWithEmailAndPassword(
            email: emailTextEditingController.text.trim(),
            password: passwordTextEditingController.text.trim()
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: 'Erro: ${msg.toString()}');
        })
    ).user;

    //Se a criação do usuário for bem-sucedida (ou seja, firebaseUser não for nulo), as informações do usuário são armazenadas em um mapa userMap,
    // com campos como 'id', 'name', 'email' e 'phone'. Em seguida, é obtida uma referência para o banco de dados do Firebase usando FirebaseDatabase.instance.ref(),
    // e o mapa userMap é salvo como um filho (child) do nó 'users' com o ID do usuário.


    if(firebaseUser != null){
      Map userMap = {
        'id': firebaseUser.uid,
        'name': nameTextEditingController.text.trim(),
        'email': emailTextEditingController.text.trim(),
        'phone': phoneTextEditingController.text.trim(),
      };
     DatabaseReference reference = FirebaseDatabase.instance.ref().child('users');
     reference.child(firebaseUser.uid).set(userMap);

     //Além disso, a variável global currentFirebaseUser é atualizada com o objeto firebaseUser e uma mensagem de sucesso é exibida usando Fluttertoast.showToast().
      // Em seguida, a tela CarInfoScreen é navegada usando Navigator.push().

     currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: 'A conta foi criada com sucesso!');
      Navigator.push(context, MaterialPageRoute(builder: (context) => MySplashScreen()));
    }
    else {
      // Caso a criação do usuário não seja bem-sucedida, é exibida uma mensagem de erro e o diálogo de progresso é fechado.
      Navigator.pop(context);
      Fluttertoast.showToast(msg: 'A conta não foi criada.');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('images/logo.png'),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Registrar-se Como Motorista',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: nameTextEditingController,
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                    labelText: 'Nome',
                    hintText: 'Nome',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey,
                    )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey,
                    )),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 10)),
              ),
              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Email',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey,
                    )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey,
                    )),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 10)),
              ),
              TextField(
                controller: phoneTextEditingController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                    labelText: 'Telefone',
                    hintText: 'Telefone',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey,
                    )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey,
                    )),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 10)),
              ),
              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                    labelText: 'Senha',
                    hintText: 'Senha',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey,
                    )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey,
                    )),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 10)),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    validateForm();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => CarInfoScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreenAccent),
                  child: const Text(
                    'Criar Conta',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text(
                  'já tem uma conta? Entre aqui',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
