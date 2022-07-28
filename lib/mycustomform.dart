import 'package:flutter/material.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _cForm = GlobalKey<FormState>();

  validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  TextEditingController username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _cForm,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Name',
                  label: const Text('Name'),
                ),
                controller: username,
                validator: (value) {
                  // var nonNullValue = value ?? '';
                  if (value!.isEmpty) {
                    // value! // checks if it is null?
                    return ("Name is required");
                  }
                  // if (!nonNullValue.contains("@")) {
                  //   return ("username should contains @");
                  // }
                  return null;
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                validator: (value) => validateEmail(value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'example@example123.com',
                  label: const Text('Email'),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Mobile Number',
                  label: const Text('Mobile Number'),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Image URl',
                  label: const Text('Image URL'),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_cForm.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')));
                    // Navigator.of(context).pushAndRemoveUntil(
                    //   MaterialPageRoute(builder: (_) => const HomePage()),
                    //   (route) => false,

                  }
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
