
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_app/infoHandler/app_info.dart';
import 'package:users_app/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //responsável por garantir que a inicialização correta dos widgets do Flutter tenha ocorrido antes de executar o restante do código.
  await Firebase
      .initializeApp(); // aqui  você está garantindo que o Firebase seja inicializado corretamente e esteja pronto para uso antes de executar a sua aplicação Flutter. Isso permite que você utilize os serviços do Firebase de forma segura e consistente durante a execução do seu aplicativo.
  runApp(MyApp(
    child: ChangeNotifierProvider(
      create: (context) => AppInfo(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MySplashScreen(),
        debugShowCheckedModeBanner: false,
        // home:
      ),
    ),
  ));
}

class MyApp extends StatefulWidget {
  //  é um widget que possui um estado mutável.
  final Widget? child;

  MyApp({super.key, this.child});

  static void restartApp(BuildContext context) {
    // Esse método é usado para reiniciar a aplicação. Ele encontra o estado mais próximo de _MyAppState no ancestral do context e chama o método restartApp() desse estado.
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key =
      UniqueKey(); // Essa chave será usada para controlar a atualização do estado do widget.

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
        key: key,
        child: widget
            .child!); //A utilização de KeyedSubtree com uma chave permite que o Flutter otimize a atualização do widget, preservando o estado existente.
  }
}
//Resumindo, a classe MyApp é um StatefulWidget personalizado que gerencia o estado de _MyAppState. O widget MyApp pode ser reiniciado chamando o método estático restartApp(), que atualiza a chave e reconstrói o widget, mantendo o estado atualizado.
