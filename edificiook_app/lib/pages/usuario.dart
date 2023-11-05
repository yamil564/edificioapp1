import 'package:flutter/material.dart';

class Usuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: new AppBar(
        title: Text('Pagina de usuarios'),
      ),
      body: new Column(
        children: <Widget>[
          new Text('Estamos en usuarios'),
        ],
      ),
    );
  }
}
