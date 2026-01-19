import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(home: SharedPrefExample()));
}

class SharedPrefExample extends StatefulWidget {
  @override
  _SharedPrefExampleState createState() => _SharedPrefExampleState();
}

class _SharedPrefExampleState extends State<SharedPrefExample> {
  String? username;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> saveData(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', value);
    setState(() {
      username = value;
    });
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
    });
  }

  Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    setState(() {
      username = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pertemuan 13: SharedPreferences")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Masukkan Nama"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => saveData(_controller.text),
              child: Text("Simpan"),
            ),
            ElevatedButton(onPressed: clearData, child: Text("Hapus")),
            SizedBox(height: 20),
            Text(
              username == null
                  ? "Belum ada data disimpan"
                  : "Data tersimpan: $username",
            ),
          ],
        ),
      ),
    );
  }
}
