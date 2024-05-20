import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

Future<Map<String, num>?>? getLivePetrolCost() async {
  Map<String, double> prices = {};

  final response = await http.Client()
      .get(Uri.parse("https://www.goodreturns.in/petrol-price.html"));

  if (response.statusCode != 200) {
    return null;
  }

  final document = parser.parse(response.body);

  try {
    var responseString = document.getElementsByClassName("even_row");

    responseString.addAll(document.getElementsByClassName("odd_row"));
    for (final element in responseString) {
      prices[element.children[0].children[0].text.trim()] = double.parse(
          element.children[1].text.trim().replaceAll(RegExp(r'[^0-9.]'), ''));
    }
  } catch (e) {
    return null;
  }

  return prices;
}
