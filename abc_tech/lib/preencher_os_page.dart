// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:abc_tech/finalizar_os_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PreencherOsPage extends StatefulWidget {
  const PreencherOsPage({super.key});

  @override
  State<PreencherOsPage> createState() => _PreencherOsPageState();
}

class _PreencherOsPageState extends State<PreencherOsPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController codigo = TextEditingController();
  String _value = 'Selecionar categoria';
  List<String> listaServicos = [];
  late DateTime inicio;
  String lat = '';
  String long = '';

  //localização inicial
  Future<Position> getLocalInicial() async {
    return await Geolocator.getCurrentPosition();
  }

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
        child: SingleChildScrollView(
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
                      value: 'Selecionar categoria',
                      child: Text('Selecionar categoria'),
                    ),
                    DropdownMenuItem(
                      value: 'Manutenção geladeira',
                      child: Text('Manutenção geladeira'),
                    ),
                    DropdownMenuItem(
                      value: 'Manutenção microondas',
                      child: Text('Manutenção microondas'),
                    ),
                    DropdownMenuItem(
                      value: 'Manutenção máquina de lavar',
                      child: Text('Manutenção máquina de lavar'),
                    ),
                    DropdownMenuItem(
                      value: 'Instalação de rede elétrica',
                      child: Text('Instalação de rede elétrica'),
                    ),
                  ],
                  onChanged: (value) {
                    _value = value!;
                  },
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.black38,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    if (_value != "Selecionar categoria") {
                      setState(() {
                        listaServicos.add(_value);
                      });
                    }
                  },
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
                const SizedBox(height: 8),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    itemCount: listaServicos.length,
                    itemBuilder: (context, index) {
                      return Text(listaServicos[index]);
                    },
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.black38,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        listaServicos.isNotEmpty) {
                      //Mensagem de sucesso
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Atendimento iniciado, aguarde...'),
                        backgroundColor: Colors.black38,
                      ));
                      // Setando data e hora inicial
                      inicio = DateTime.now();
                      // Setando localização inicial

                      await getLocalInicial().then((value) {
                        lat = '${value.latitude}';
                        long = '${value.longitude}';
                      });

                      // Navegando pra tela seguinte
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FinalizarOS(
                                  codigo: codigo.text,
                                  listaServicos: listaServicos,
                                  now: inicio,
                                  latInicial: lat,
                                  longInicial: long,
                                )),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Preencha o campo ou adicione ao menos um serviço.'),
                        backgroundColor: Colors.redAccent,
                      ));
                    }
                  },
                  child: const Text(
                    'Iniciar Atendimento',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
