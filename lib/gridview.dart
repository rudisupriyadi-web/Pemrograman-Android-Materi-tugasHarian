import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyGridView()));
}

class MyGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pertemuan 5: Widget Lanjutan')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Orang $index'),
                  subtitle: Text('Detail user ke-$index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
