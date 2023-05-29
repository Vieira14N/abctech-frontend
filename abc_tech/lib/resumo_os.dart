// ignore_for_file: avoid_print

import 'package:abc_tech/home_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResumoOS extends StatelessWidget {
  final String codigo;
  final List<String> listaServicos;
  final DateTime now;
  final DateTime then;
  final String latInicial;
  final String longInicial;
  final String latFinal;
  final String longFinal;

  const ResumoOS({
    super.key,
    required this.codigo,
    required this.listaServicos,
    required this.now,
    required this.then,
    required this.latInicial,
    required this.longInicial,
    required this.latFinal,
    required this.longFinal,
  });

  // teste

  Future<Album> createAlbum() async {
    final response = await http.post(
      Uri.parse('http://192.168.137.39:8080/servico'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "codigo": "ian",
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print('succes');
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print('error');
      throw Exception('Failed to create album.');
    } 
  }

  // Chamada para envio

  Future<String?> criarServico(
      String codigo,
      List<String> listaServicos,
      String localizacaoInicial,
      String localizacaoFinal,
      String inicial,
      String fim
      ) async {
    final response = await http.post(
      Uri.parse('http://192.168.137.39:8080/servico'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "codigo": codigo,
        "listaServicos": listaServicos,
        "localizacaoInicial": localizacaoInicial,
        "localizacaoFinal": localizacaoFinal,
        "inicial": inicial,
        "fim": fim
      }),
    );

    if (response.statusCode == 200) {
      print('success');
      
      return '200';
    } else {
      print("error");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(now);
    String formattedDateFinal = DateFormat('dd-MM-yyyy HH:mm:ss').format(then);

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Atedimento finalizado, abaixo seguem os detalhes do serviço prestado.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('- Código do prestador: $codigo'),
              const SizedBox(height: 16),
              const Text(
                '- Data e hora de início:',
                style: TextStyle(fontSize: 16),
              ),
              Text(formattedDate),
              // Localização
              const SizedBox(height: 16),
              const Text(
                '- Localização inicial:',
                style: TextStyle(fontSize: 16),
              ),
              Text('Latitude: $latInicial'),
              Text('Longitude: $longInicial'),
              const SizedBox(height: 16),
              const Text(
                '- Serviços selecionados:',
                style: TextStyle(fontSize: 16),
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
              const Text(
                '- Data e hora de término:',
                style: TextStyle(fontSize: 16),
              ),
              Text(formattedDateFinal),
              // Localização
              const SizedBox(height: 16),
              const Text(
                '- Localização final:',
                style: TextStyle(fontSize: 16),
              ),
              Text('Latitude: $latFinal'),
              Text('Longitude: $longFinal'),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.black38,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: ()  {
                  Future<String?> result = criarServico(
                    codigo,
                    listaServicos,
                    '$latInicial,$longInicial',
                    '$latFinal,$longFinal',
                    formattedDate,
                    formattedDateFinal
                  );

                  result.then((value) {
                      if(value == '200'){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Atendimento enviado'),
                        backgroundColor: Colors.greenAccent,
                      ));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Erro ao enviar atendimento'),
                        backgroundColor: Colors.redAccent,
                      ));
                  }
                  });
                  
                },
                child: const Text(
                  'Enviar Atendimento',
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

class Servico {
  final String codigo;
  final List<String> listaServicos;
  final String localizacaoInicial;
  final String localizacaoFinal;
  final String inicial;
  final String fim;

  const Servico(
      {required this.codigo,
      required this.listaServicos,
      required this.localizacaoInicial,
      required this.localizacaoFinal,
      required this.inicial,
      required this.fim});

  factory Servico.fromJson(Map<String, dynamic> json) {
    return Servico(
      codigo: json['codigo'],
      listaServicos: json['listaServicos'],
      localizacaoInicial: json['localizacaoInicial'],
      localizacaoFinal: json['localizacaoFinal'],
      inicial: json['inicial'],
      fim: json['fim'],
    );
  }
}

class Album {
  final String codigo;

  const Album({required this.codigo});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      codigo: json['codigo'],
    );
  }
}
