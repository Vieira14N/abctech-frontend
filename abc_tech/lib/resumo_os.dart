import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {

    String formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(now);
    String formattedDateFinal = DateFormat('dd-MM-yyyy HH:mm').format(then);

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
            ],
          ),
        ),
      ),
    );
  }
}
