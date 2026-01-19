import 'package:flutter/material.dart';

class MyStatefulPage extends StatefulWidget {
  @override
  State<MyStatefulPage> createState() => _MyStatefulPageState();
}

class _MyStatefulPageState extends State<MyStatefulPage> {
  // List angka
  List<int> numbers = [];

  // Controller form
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _agree = false;
  String? _selectedGender;

  void _tambahAngka() {
    setState(() {
      numbers.add(numbers.length + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stateful Widget + Form Validation"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Bagian daftar angka
              Text(
                "Daftar Angka (klik tombol untuk menambah)",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _tambahAngka,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 10),
                ),
                child: Text(
                  "Tambah Angka",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(height: 10),

              // Menampilkan daftar angka dengan warna ganjil/genap
              Column(
                children: numbers.map((number) {
                  return Text(
                    'Angka ke-$number',
                    style: TextStyle(
                      fontSize: 18,
                      color: number % 2 == 0 ? Colors.blue : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }).toList(),
              ),

              Divider(height: 40, thickness: 2),

              // TextField nama
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Nama Lengkap",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // TextField email dengan validasi
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email tidak boleh kosong";
                  }
                  // Validasi format email sederhana
                  if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(value)) {
                    return "Format email tidak valid";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Dropdown pilih gender
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: InputDecoration(
                  labelText: "Pilih Jenis Kelamin",
                  border: OutlineInputBorder(),
                ),
                items: ['Laki-laki', 'Perempuan'].map((gender) {
                  return DropdownMenuItem(value: gender, child: Text(gender));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Harap pilih jenis kelamin";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Checkbox persetujuan
              CheckboxListTile(
                title: Text("Saya setuju dengan syarat dan ketentuan"),
                value: _agree,
                onChanged: (value) {
                  setState(() {
                    _agree = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                subtitle: !_agree
                    ? Text(
                        "Harus disetujui untuk melanjutkan",
                        style: TextStyle(color: Colors.red),
                      )
                    : null,
              ),
              SizedBox(height: 16),

              // Tombol submit
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (!_agree) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Harap setujui syarat terlebih dahulu"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "✅ Data Valid!\n"
                          "Nama: ${_nameController.text}\n"
                          "Email: ${_emailController.text}\n"
                          "Gender: $_selectedGender",
                        ),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
