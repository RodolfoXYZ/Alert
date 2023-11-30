// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../models/occurrences.dart';
import '../services/occurrence_service.dart';

class OccurrenceHistory extends StatelessWidget {
  const OccurrenceHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final OccurrenceService occurrenceService = OccurrenceService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Ocorrências'),
      ),
      body: FutureBuilder<List<Occurrence>>(
        future: occurrenceService.getOccurrencesFromFirestore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma ocorrência encontrada.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Occurrence occurrence = snapshot.data![index];
                int occurrenceNumber = index + 1; // Número da ocorrência

                return ListTile(
                  title: Text('Ocorrência $occurrenceNumber'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tipo: ${occurrence.tipo}'),
                      Text('Localização: ${occurrence.localizacao}'),
                      Text('Descrição: ${occurrence.descricao}'),
                      Text('Data e Hora: ${occurrence.dataHora}'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
