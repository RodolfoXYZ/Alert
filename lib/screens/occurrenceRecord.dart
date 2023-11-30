// ignore_for_file: file_names, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import '../services/occurrence_service.dart';
import '../models/occurrences.dart';
import 'package:intl/intl.dart';

class OccurrenceRecord extends StatelessWidget {
  final String initialOccurrenceType;

  OccurrenceRecord({super.key, required this.initialOccurrenceType});

  final OccurrenceService occurrenceService = OccurrenceService();

  @override
  Widget build(BuildContext context) {
    DateTime currentDateTime = DateTime.now();
    String formattedDateTime = DateFormat('dd/MM/yyyy HH:mm:ss').format(currentDateTime);

    TextEditingController tipoController =
        TextEditingController(text: initialOccurrenceType);
    TextEditingController localizacaoController = TextEditingController();
    TextEditingController descricaoController = TextEditingController();
    TextEditingController dataHoraController =
        TextEditingController(text: formattedDateTime);

    void registrarOcorrencia() async {
      try {
        if (tipoController.text.isEmpty ||
            localizacaoController.text.isEmpty ||
            descricaoController.text.isEmpty) {
          // Alerta se algum campo estiver vazio
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Erro de Validação'),
                content: const Text('Por favor, preencha todos os campos.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          Occurrence occurrence = Occurrence(
            userId: '', // O ID do usuário será atribuído automaticamente
            tipo: tipoController.text,
            localizacao: localizacaoController.text,
            descricao: descricaoController.text,
            dataHora: dataHoraController.text,
          );

          await occurrenceService.saveOcurrenceToFirestore(occurrence);
          // Lógica após o registro bem-sucedido
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Sucesso'),
                content: const Text('Ocorrência registrada com sucesso!'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } catch (error) {
        // Alerta se houver um erro ao registrar a ocorrência
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erro'),
              content: Text('Erro ao registrar a ocorrência: $error'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        print('Erro ao registrar a ocorrência: $error');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Ocorrências'),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              Inputs(
                label: "Tipo",
                hint: "Tipo de Ocorrência",
                controller: tipoController,
                isReadOnly: true,
              ),
              Inputs(
                label: "Localização",
                hint: "Local da Ocorrência",
                controller: localizacaoController,
              ),
              Inputs(
                label: "Descrição",
                hint: "Descrição da Ocorrência",
                controller: descricaoController,
              ),
              Inputs(
                label: "Data e Hora",
                hint: "Data e Hora da Ocorrência",
                controller: dataHoraController,
                isReadOnly: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: registrarOcorrencia,
                child: const Text('Registrar Ocorrência'),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ],
      ),
    );
  }
}

class Inputs extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final bool isReadOnly;

  const Inputs({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 20)),
          const SizedBox(
            height: 6,
          ),
          TextField(
            controller: controller,
            obscureText: isPassword,
            autofocus: false,
            readOnly: isReadOnly,
            enabled: !isReadOnly,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 10),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
