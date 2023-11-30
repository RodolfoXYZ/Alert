// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticateService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> cadastrarUsuario({
    required String nome,
    required String dataNascimento,
    required String cpf,
    required String rg,
    required String telefone,
    required String endereco,
    required String email,
    required String senha,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: senha);

      String userID = userCredential.user!.uid;

      await firebaseFirestore.collection('Usuários').doc(userID).set({
        'nome': nome,
        'dataNascimento': dataNascimento,
        'cpf': cpf,
        'rg': rg,
        'telefone': telefone,
        'endereco': endereco,
      });
    } catch (error) {
      print('Erro ao cadastrar o usuário: $error');
      rethrow;
    }
  }

  Future<User?> fazerLogin({
    required String email,
    required String senha,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      return userCredential.user; // Retorna o usuário autenticado
    } catch (error) {
      print('Erro ao fazer login: $error');
      return null;
    }
  }

  Future<Map<String, dynamic>?> obterDadosUsuario(String userID) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
          .collection('Usuários')
          .doc(userID)
          .get();

      if (snapshot.exists) {
        return snapshot.data(); // Retorna os dados do usuário como um mapa
      } else {
        print('Usuário não encontrado');
        return null;
      }
    } catch (error) {
      print('Erro ao obter dados do usuário: $error');
      return null;
    }
  }

  Future<void> fazerLogout() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      print('Erro ao fazer logout: $e');
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      return firebaseAuth.currentUser;
    } catch (error) {
      print('Erro ao obter usuário atual: $error');
      return null;
    }
  }
}
