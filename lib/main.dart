import 'package:currency_converter_app/currency_data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Currency Converter',
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final currencyList = [
    'USD',
    'INR',
    'EUR',
    'AUD',
    'JPY',
  ];
  var selectedCurrencyFrom = 'USD';
  var selectedCurrencyTo = 'INR';
  TextEditingController currencyCodeController = TextEditingController();
  var cAmount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Currency Converter',
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFaaffa9),
                Color(0xFF11ffbd),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              Text(
                cAmount == null ? 'Hola!' : cAmount,
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    DropdownButton<String>(
                      items: currencyList.map((String dropDownItems) {
                        return DropdownMenuItem<String>(
                          value: dropDownItems,
                          child: Text(
                            dropDownItems,
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          selectedCurrencyFrom = value;
                        });
                      },
                      value: selectedCurrencyFrom,
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Icon(
                      Icons.compare_arrows,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    DropdownButton<String>(
                      items: currencyList.map((String dropDownItems) {
                        return DropdownMenuItem<String>(
                          value: dropDownItems,
                          child: Text(
                            dropDownItems,
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          selectedCurrencyTo = value;
                        });
                      },
                      value: selectedCurrencyTo,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextField(
                      controller: currencyCodeController,
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 25.0,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Amount?',
                        hintStyle: TextStyle(
                          color: Colors.indigo.withOpacity(0.8),
                        ),
                        border: InputBorder.none,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              GestureDetector(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 3,
                        spreadRadius: 2.5,
                        offset: Offset(3, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFaaffa9),
                        Color(0xFF11ffbd),
                      ],
                    ),
                  ),
                  child: Text(
                    'Convert',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: () async {
//                print(currencyCodeController.text.runtimeType);
                  double doubleCash = double.parse(currencyCodeController.text);
//                print(doubleCash.runtimeType);
                  var convertedAmount = await convertCurrency(
                      doubleCash, selectedCurrencyFrom, selectedCurrencyTo);
//                print('$convertedAmount From Main');
                  setState(() {
                    currencyCodeController.text = '';
                    cAmount = convertedAmount;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
