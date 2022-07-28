import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formforimage/homepage.dart';
import 'package:phone_number/phone_number.dart';

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
  TextEditingController phone = TextEditingController();
  Country _selectedDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode('977');
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
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                        "CountryPickerDialog (has priorityList['TR,'US'])"),
                    ListTile(
                      onTap: _openCountryPickerDialog,
                      title: _buildDialogItem(_selectedDialogCountry),
                    ),
                  ],
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "mobile number is required";
                  } else if (value.length != 10) {
                    return "mobile number exact 10 digit";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Mobile Number',
                  label: const Text('Mobile Number'),
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
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const HomePage()),
                      (route) => false,
                    );
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

  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(width: 8.0),
          Text("+${country.phoneCode}"),
          const SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      );
  void _openCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.pink),
          child: CountryPickerDialog(
            titlePadding: const EdgeInsets.all(8.0),
            searchCursorColor: Colors.pinkAccent,
            searchInputDecoration: const InputDecoration(hintText: 'Search...'),
            isSearchable: true,
            title: const Text('Select your phone code'),
            onValuePicked: (Country country) =>
                setState(() => _selectedDialogCountry = country),
            itemBuilder: _buildDialogItem,
            priorityList: [
              CountryPickerUtils.getCountryByIsoCode('Np'),
              CountryPickerUtils.getCountryByIsoCode('NP'),
            ],
          ),
        ),
      );
}
