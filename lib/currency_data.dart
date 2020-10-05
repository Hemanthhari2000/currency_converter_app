import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

final apiKey = '&apiKey=Your API Key';
final domain = 'https://free.currconv.com/api/v7/convert?q=';
final compact = '&compact=ultra';

class ConvertMoney {
  final double amount;
  ConvertMoney(this.amount);
}

String conCate(String from, String to) {
  String cCode = from + '_' + to;
  return cCode;
}

Future convertCurrency(double cash, String from, String to) async {
  String curCode = conCate(from, to);
  final URL = domain + curCode + apiKey + compact;

  var data = await http.get(URL);
  if (data.statusCode == 200) {
    var dataDecoded = json.decode(data.body);
    var money = dataDecoded[curCode];
    ConvertMoney amount = ConvertMoney(money);
//    print(amount.amount);
//    print(amount.amount * cash);
    return ((amount.amount * cash).toStringAsFixed(2));
  } else {
    print('Error');
  }
}
