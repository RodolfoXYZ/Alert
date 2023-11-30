// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/authenticate_service.dart';
import 'login.dart'; // Importe a página de login ou substitua pelo caminho correto

class Cadastro extends StatelessWidget {
  Cadastro({super.key});

  final AuthenticateService authService = AuthenticateService();

  @override
  Widget build(BuildContext context) {
    TextEditingController nomeController = TextEditingController();
    TextEditingController dataNascimentoController = TextEditingController();
    TextEditingController cpfController = TextEditingController();
    TextEditingController rgController = TextEditingController();
    TextEditingController telefoneController = TextEditingController();
    TextEditingController enderecoController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController senhaController = TextEditingController();

    void cadastrarUsuario() async {
      try {
        await authService.cadastrarUsuario(
          nome: nomeController.text,
          dataNascimento: dataNascimentoController.text,
          cpf: cpfController.text,
          rg: rgController.text,
          telefone: telefoneController.text,
          endereco: enderecoController.text,
          email: emailController.text,
          senha: senhaController.text,
        );

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sucesso'),
              content: const Text('Cadastro realizado com sucesso!'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Fechar o diálogo
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Caixas()),
                    );
                  },
                ),
              ],
            );
          },
        );
      } catch (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erro'),
              content: Text('Erro ao cadastrar o usuário: $error'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Fechar o diálogo
                  },
                ),
              ],
            );
          },
        );
      }
    }

    String formatCPF(String value) {
      value = value.replaceAll(RegExp(r'[^0-9]'), '');

      if (value.length <= 3) {
        return value;
      } else if (value.length <= 6) {
        return '${value.substring(0, 3)}.${value.substring(3)}';
      } else if (value.length <= 9) {
        return '${value.substring(0, 3)}.${value.substring(3, 6)}.${value.substring(6)}';
      } else {
        return '${value.substring(0, 3)}.${value.substring(3, 6)}.${value.substring(6, 9)}-${value.substring(9, value.length > 11 ? 11 : value.length)}';
      }
    }

    String formatRG(String value) {
      value = value.replaceAll(RegExp(r'[^0-9]'), '');

      if (value.length <= 1) {
        return value;
      } else if (value.length <= 4) {
        return '${value.substring(0, 1)}.${value.substring(1)}';
      } else {
        return '${value.substring(0, 1)}.${value.substring(1, 4)}.${value.substring(4)}';
      }
    }

    String formatTelefone(String value) {
      // Remove todos os caracteres não numéricos
      final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');

      // Caso a entrada original tenha letras, retorne o valor original
      if (value != digitsOnly) {
        return value;
      }

      if (digitsOnly.isEmpty) {
        return value;
      } else if (digitsOnly.length <= 2) {
        return '($digitsOnly';
      } else if (digitsOnly.length <= 5) {
        return '(${digitsOnly.substring(0, 2)}) ${digitsOnly.substring(2)}';
      } else if (digitsOnly.length < 8) {
        return '(${digitsOnly.substring(0, 2)}) ${digitsOnly.substring(2, digitsOnly.length)}';
      } else if (digitsOnly.length <= 9) {
        return '(${digitsOnly.substring(0, 2)}) ${digitsOnly.substring(2, 7)}-${digitsOnly.substring(7)}';
      } else {
        // Ajuste para garantir que apenas dígitos sejam exibidos nos últimos dígitos
        String lastDigits = digitsOnly.substring(7);
        String cleanLastDigits = lastDigits.replaceAll(RegExp(r'[^0-9]'), '');
        return '(${digitsOnly.substring(0, 2)}) ${digitsOnly.substring(2, 7)}-$cleanLastDigits';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Inputs(
                label: "Nome",
                hint: "Nome Completo",
                controller: nomeController,
              ),
              Inputs(
                label: "Data de Nascimento",
                hint: "DD/MM/YYYY",
                controller: dataNascimentoController,
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter(),
                ],
              ),
              Inputs(
                label: "CPF",
                hint: "000.000.000-00",
                controller: cpfController,
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    return TextEditingValue(
                      text: formatCPF(newValue.text),
                      selection: TextSelection.collapsed(
                          offset: formatCPF(newValue.text).length),
                    );
                  }),
                ],
              ),
              Inputs(
                label: "RG",
                hint: "0.000.000",
                controller: rgController,
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(7),
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    return TextEditingValue(
                      text: formatRG(newValue.text),
                      selection: TextSelection.collapsed(
                          offset: formatRG(newValue.text).length),
                    );
                  }),
                ],
              ),
              Inputs(
                label: "Telefone",
                hint: "(81) 99595-7825",
                controller: telefoneController,
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    final newText = formatTelefone(newValue.text);
                    return TextEditingValue(
                      text: newText,
                      selection:
                          TextSelection.collapsed(offset: newText.length),
                    );
                  }),
                ],
              ),
              Inputs(
                label: "Endereço",
                hint: "Rua, Número da Residência - Bairro",
                controller: enderecoController,
              ),
              Inputs(
                label: "E-mail",
                hint: "abc@gmail.com",
                controller: emailController,
              ),
              Inputs(
                label: "Senha",
                hint: "8 dígitos",
                controller: senhaController,
                isPassword: true,
                inputFormatter: [LengthLimitingTextInputFormatter(8)],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  // Verificar se todos os campos estão preenchidos corretamente
                  if (nomeController.text.isNotEmpty &&
                      dataNascimentoController.text.length == 10 &&
                      cpfController.text.length == 14 &&
                      rgController.text.length == 9 &&
                      telefoneController.text.length == 15 &&
                      enderecoController.text.isNotEmpty &&
                      emailController.text.isNotEmpty &&
                      senhaController.text.length == 8) {
                    // Se todos os campos estão corretos, executar o cadastro
                    cadastrarUsuario();
                  } else {
                    // Caso contrário, mostrar mensagem de erro
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Erro'),
                          content: const Text(
                              'Por favor, preencha todos os campos corretamente.'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Fechar o diálogo
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Cadastrar'),
              ),
              const SizedBox(height: 60),
            ],
          )
        ],
      ),
    );
  }
}

class Inputs extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatter;
  final bool isPassword;

  const Inputs({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.inputFormatter,
    this.isPassword = false,
  });

  @override
  _InputsState createState() => _InputsState();
}

class _InputsState extends State<Inputs> {
  bool isNameValid = false;
  bool isDataValid = false;
  bool isCPFValid = false;
  bool isRGValid = false;
  bool isTelefoneValid = false;
  bool isEnderecoValid = false;
  bool isEmailValid = false;
  bool isSenhaValid = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: const TextStyle(fontSize: 20)),
          const SizedBox(
            height: 6,
          ),
          TextField(
            controller: widget.controller,
            obscureText: widget.isPassword,
            autofocus: false,
            inputFormatters: widget.inputFormatter,
            onChanged: (value) {
              setState(() {
                if (widget.label == 'Data de Nascimento') {
                  isDataValid = value.length == 10; // DD/MM/YYYY
                } else if (widget.label == 'CPF') {
                  isCPFValid = value.length == 14; // 000.000.000-00
                } else if (widget.label == 'RG') {
                  isRGValid = value.length == 9; // 0.000.000
                } else if (widget.label == 'Telefone') {
                  isTelefoneValid = value.length == 15;
                } else if (widget.label == "Nome") {
                  isNameValid = value.isNotEmpty;
                } else if (widget.label == "Endereço") {
                  isEnderecoValid = value.isNotEmpty;
                } else if (widget.label == "E-mail") {
                  isEmailValid = value.isNotEmpty;
                } else if (widget.label == "Senha") {
                  isSenhaValid = value.length == 8;
                }
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: widget.hint,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color:
                      _getBorderColor(), // Obtém a cor da borda conforme a validação
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: Colors.red), // Borda vermelha para indicar erro
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: _getBorderColor().withOpacity(
                      0.7), // Obtém a cor da borda com transparência
                ),
              ),
              suffixIcon: _getSuffixIcon(), // Obtém o ícone de validação
            ),
          ),
        ],
      ),
    );
  }

  Color _getBorderColor() {
    if (widget.label == 'Data de Nascimento') {
      return isDataValid
          ? Colors.green
          : Colors.red; // Cor da borda para a data de nascimento
    } else if (widget.label == 'CPF') {
      return isCPFValid ? Colors.green : Colors.red; // Cor da borda para o CPF
    } else if (widget.label == 'RG') {
      return isRGValid ? Colors.green : Colors.red; // Cor da borda para o RG
    } else if (widget.label == 'Telefone') {
      return isTelefoneValid
          ? Colors.green
          : Colors.red; // Cor da borda para o Telefone
    } else if (widget.label == 'Nome') {
      return isNameValid ? Colors.green : Colors.red; // Cor da borda para o Nome
    } else if (widget.label == 'Endereço') {
      return isEnderecoValid
          ? Colors.green
          : Colors.red; // Cor da borda para o Endereço
    } else if (widget.label == 'E-mail') {
      return isEmailValid ? Colors.green : Colors.red; // Cor da borda para o Email
    } else if (widget.label == 'Senha') {
      return isSenhaValid ? Colors.green : Colors.red; // Cor da borda para a Senha
    }
    return Colors.grey; // Se nenhum campo for correspondido, retorna a cor cinza
  }

  Widget? _getSuffixIcon() {
    if (widget.label == 'Data de Nascimento') {
      return isDataValid
          ? const Icon(Icons.check,
              color: Colors.green) // Ícone de check verde para data válida
          : const Icon(Icons.error,
              color: Colors.red); // Ícone de erro vermelho para data inválida
    } else if (widget.label == 'CPF') {
      return isCPFValid
          ? const Icon(Icons.check,
              color: Colors.green) // Ícone de check verde para CPF válido
          : const Icon(Icons.error,
              color: Colors.red); // Ícone de erro vermelho para CPF inválido
    } else if (widget.label == 'RG') {
      return isRGValid
          ? const Icon(Icons.check,
              color: Colors.green) // Ícone de check verde para RG válido
          : const Icon(Icons.error,
              color: Colors.red); // Ícone de erro vermelho para RG inválido
    } else if (widget.label == 'Telefone') {
      return isTelefoneValid
          ? const Icon(Icons.check,
              color: Colors.green) // Ícone de check verde para Telefone válido
          : const Icon(Icons.error,
              color:
                  Colors.red); // Ícone de erro vermelho para Telefone inválido
    } else if (widget.label == 'Nome') {
      return isNameValid
          ? const Icon(Icons.check,
              color: Colors.green) // Ícone de check verde para Nome válido
          : const Icon(Icons.error,
              color: Colors.red); // Ícone de erro vermelho para Nome inválido
    } else if (widget.label == 'Endereço') {
      return isEnderecoValid
          ? const Icon(Icons.check,
              color: Colors.green) // Ícone de check verde para Endereço válido
          : const Icon(Icons.error,
              color: Colors.red); // Ícone de erro vermelho para Endereço inválido
    } else if (widget.label == 'E-mail') {
      return isEmailValid
          ? const Icon(Icons.check,
              color: Colors.green) // Ícone de check verde para Email válido
          : const Icon(Icons.error,
              color: Colors.red); // Ícone de erro vermelho para Email inválido
    } else if (widget.label == 'Senha') {
      return isSenhaValid
          ? const Icon(Icons.check,
              color: Colors.green) // Ícone de check verde para Senha válida
          : const Icon(Icons.error,
              color:
                  Colors.red); // Ícone de erro vermelho para Senha inválida
    }
    return null;
  }
}

class DataInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = _formatDate(newValue.text);
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  String _formatDate(String value) {
    value = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (value.length <= 2) {
      return value;
    } else if (value.length <= 4) {
      return '${value.substring(0, 2)}/${value.substring(2)}';
    } else {
      return '${value.substring(0, 2)}/${value.substring(2, 4)}/${value.substring(4, value.length > 8 ? 8 : value.length)}';
    }
  }
}
