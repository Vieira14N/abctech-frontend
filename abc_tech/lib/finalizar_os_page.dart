import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FinalizarOS extends StatelessWidget {
  final String codigo;
  final List<String> listaServicos;
  final DateTime now;
  final String latInicial;
  final String longInicial;

  const FinalizarOS({
    super.key,
    required this.codigo,
    required this.listaServicos,
    required this.now,
    required this.latInicial,
    required this.longInicial,
  });

  @override
  Widget build(BuildContext context) {
    
  String formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(now);
  
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
                'Atedimento iniciado, abaixo seguem os detalhes. Ao finalizar, clique em "Finalizar atendimet":',
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
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.black38,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    
                  },
                  child: const Text(
                    'Finalizar Atendimento',
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
