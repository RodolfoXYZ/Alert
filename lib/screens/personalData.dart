// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../services/authenticate_service.dart';

class PersonalData extends StatelessWidget {
  const PersonalData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _loadUserData(), // Carregar os dados do usuário
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar dados: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Dados do usuário não encontrados'));
          } else {
            final userData = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildUserDataItem('Nome', userData['nome']),
                _buildUserDataItem('Data de Nascimento', userData['dataNascimento']),
                _buildUserDataItem('CPF', userData['cpf']),
                _buildUserDataItem('RG', userData['rg']),
                _buildUserDataItem('Telefone', userData['telefone']),
                _buildUserDataItem('Endereço', userData['endereco']),
                // Adicione outros campos conforme necessário
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildUserDataItem(String label, String value) {
    return ListTile(
      title: Text(label),
      subtitle: Text(value),
    );
  }

  Future<Map<String, dynamic>?> _loadUserData() async {
    final authService = AuthenticateService();
    final currentUser = await authService.getCurrentUser();

    if (currentUser != null) {
      final userData = await authService.obterDadosUsuario(currentUser.uid);
      return userData;
    }

    return null;
  }
}
