import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Price Prediction',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  var data = {};
  double ans = 0;

  void formSubmit() async {
    setState(() {
      ans = 1;
    });
    String url = "http://carprice-aniket61.herokuapp.com/get";
    var res = await http.post(Uri.parse(url),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    setState(() {
      ans = double.parse(res.body.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: SafeArea(
              child: Text(
                "Car Price Prediction",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          ans == 1
              ? const CircularProgressIndicator()
              : ans == 0
                  ? Image(
                      image: AssetImage('images/main.gif'),
                      height: 300,
                      width: 300,
                    )
                  : Text(
                      "₹${ans}",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
          Form(
              key: _formKey,
              child: Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  child: ListView(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Model of Car",
                          hintText: "Year",
                        ),
                        onChanged: (val) {
                          data['year'] = val;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Orignal Price of Car",
                          hintText: "Price",
                        ),
                        onChanged: (val) {
                          data['pprice'] = val;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Total KMs Driven",
                          hintText: "Killometers",
                        ),
                        onChanged: (val) {
                          data['kms'] = val;
                        },
                      ),
                      const SizedBox(height: 15),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        hint: Text("Fuel Type"),
                        value: data['fuel'],
                        isExpanded: true,
                        items: <String>[
                          'Petrol',
                          'Diesel',
                          'CNG',
                          'LPG',
                          'Electric'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (v) {
                          setState(() {
                            data['fuel'] = v;
                          });
                        },
                      ),
                      const SizedBox(height: 15),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        hint: Text("Transmission"),
                        value: data['transmission'],
                        isExpanded: true,
                        items:
                            <String>['Manual', 'Automatic'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (v) {
                          setState(() {
                            data['transmission'] = v;
                          });
                        },
                      ),
                      const SizedBox(height: 15),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        hint: Text("Seller Type"),
                        value: data['seller_type'],
                        isExpanded: true,
                        items: <String>[
                          'Dealer',
                          'Individual',
                          'Trustmark Dealer'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (v) {
                          setState(() {
                            data['seller_type'] = v;
                          });
                        },
                      ),
                      const SizedBox(height: 15),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        hint: Text("Owner Type"),
                        isExpanded: true,
                        value: data['owner'],
                        items: <String>[
                          'First Owner',
                          'Second Owner',
                          'Third Owner',
                          'Fourth & Above Owner',
                          'Test Drive Car'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (v) {
                          setState(() {
                            data['owner'] = v;
                          });
                        },
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                          onPressed: formSubmit,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "CALCULATE",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
