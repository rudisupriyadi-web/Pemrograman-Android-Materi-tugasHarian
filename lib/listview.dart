import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyListView()));
}

class MyListView extends StatelessWidget {
  final List<String> names = ["Andi", "Budi", "Citra", "Dewi", "Eko"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pertemuan 5: Widget Lanjutan')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text(names[index]),
                    subtitle: Text('Mahasiswa ke-${index + 1}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
