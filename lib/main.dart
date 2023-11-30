import 'package:alert/screens/occurrenceHistory.dart';
import 'package:alert/screens/occurrenceRecord.dart';
import 'package:alert/screens/personalData.dart';
import 'package:alert/screens/termsOfUse.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'screens/cadastro.dart';
import 'screens/login.dart';
import 'screens/telaPrincipal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Garante que os widgets estão inicializados

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Flutter Hello World',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      // A widget which will be started on application startup
      initialRoute: '/',
      routes: {
        '/': (context) => Caixas(),
        '/cadastro': (context) => Cadastro(),
        '/home': (context) => const ScafoldTelaPrincipal(),
        '/Historico-Ocorrencias': (context) => const OccurrenceHistory(),
        '/Registro-Ocorrencias': (context) => OccurrenceRecord(initialOccurrenceType: '',),
        '/Dados-Pessoais': (context) => const PersonalData(),
        '/Termos-de-Uso': (context) => const TermsOfUse(),
      },
    );
  }
}
