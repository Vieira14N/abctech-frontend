import 'package:flutter/material.dart';

class PreencherOsPage extends StatefulWidget {
  const PreencherOsPage({super.key});

  @override
  State<PreencherOsPage> createState() => _PreencherOsPageState();
}

class _PreencherOsPageState extends State<PreencherOsPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController codigo = TextEditingController();
  final String _value = '-1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ABC TechServices',
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Preencher ordem de serviço:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: codigo,
                decoration: InputDecoration(
                    labelText: 'Código do Prestador',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Preencha o campo!";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                value: _value,
                items: const [
                  DropdownMenuItem(
                      value: '-1', child: Text('Selecionar categoria')),
                  DropdownMenuItem(
                      value: '1', child: Text('Manutenção geladeira')),
                  DropdownMenuItem(
                      value: '2', child: Text('Manutenção microondas')),
                  DropdownMenuItem(
                      value: '3', child: Text('Manutenção máquina de lavar')),
                  DropdownMenuItem(
                      value: '4', child: Text('Instalação de rede elétrica')),
                ],
                onChanged: (value) {},
                validator: (value) {
                  if (value == '-1') {
                    return 'Selecione uma categoria';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.black38,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {},
                child: const Text(
                  'Adicionar serviço',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Serviços selecionados:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.black38,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {},
                child: const Text(
                  'Iniciar Atendimento',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
