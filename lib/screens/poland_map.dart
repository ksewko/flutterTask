import 'package:flutter/material.dart';

class PolandMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color mainColor = Colors.deepPurple;

    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa Polski"),
        backgroundColor: mainColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 25.0, 0, 0),
        child: Image.network(
            'https://i.pinimg.com/originals/11/7f/c2/117fc2e42774f093bd7d1ff54f8121f5.png'),
      ),
    );
  }
}
