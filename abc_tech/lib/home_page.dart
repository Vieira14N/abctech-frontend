import 'package:abc_tech/preencher_os_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              onPressed: () {
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
