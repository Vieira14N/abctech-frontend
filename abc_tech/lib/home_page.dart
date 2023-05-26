// ignore_for_file: use_build_context_synchronously

import 'package:abc_tech/preencher_os_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  //localização autorização
  Future<Position?> getAutorizacao() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Serviço de localização desabilitado.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Serviço de localização não autorizado.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Serviço de localização não autorizado permanentemente.');
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox.shrink(),
            Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: const Text(
                  'ABC TechServices',
                  style: TextStyle(fontSize: 30),
                )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(12),
                  backgroundColor: Colors.black38,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () async {
                await getAutorizacao();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PreencherOsPage()),
                );
              },
              child: const Text(
                'Acessar',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
