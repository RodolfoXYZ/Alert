// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/occurrences.dart';

class OccurrenceService {
  Future<void> saveOcurrenceToFirestore(Occurrence occurrence) async {
    try {
      // Verifica se o usuário está autenticado
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('Usuário não autenticado. Incapaz de salvar a ocorrência.');
        return;
      }

      // Obtém o ID do usuário logado
      String userId = user.uid;

      // Associa o ID do usuário à ocorrência
      occurrence.userId = userId;

      // Coleção de ocorrências
      CollectionReference occurrencesCollection =
          FirebaseFirestore.instance.collection('Ocorrências');

      // Cria um novo documento na coleção com um ID gerado automaticamente
      await occurrencesCollection.add(occurrence.toMap());

      print('Ocorrência salva com sucesso no Cloud Firestore');
    } catch (e, stackTrace) {
      print('Erro ao salvar ocorrência: $e');
      print('StackTrace: $stackTrace');
    }
  }

  Future<List<Occurrence>> getOccurrencesFromFirestore() async {
    List<Occurrence> ocurrencesList = [];

    try {
      // Verifica se o usuário está autenticado
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('Usuário não autenticado. Incapaz de obter ocorrências.');
        return ocurrencesList;
      }

      // Obtém o ID do usuário logado
      String userId = user.uid;

      // Consulta as ocorrências associadas ao usuário logado
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Ocorrências')
          .where('userId', isEqualTo: userId)
          .orderBy('dataHora', descending: false)
          .get();

      // Mapeia os documentos para objetos de ocorrência e os adiciona à lista
      ocurrencesList = querySnapshot.docs
          .map((doc) => Occurrence.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return ocurrencesList;
    } catch (e, stackTrace) {
      print('Erro ao obter ocorrências: $e');
      print('StackTrace: $stackTrace');
      return ocurrencesList;
    }
  }
}
