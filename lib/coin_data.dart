import 'package:http/http.dart' as http;
import 'dart:convert';

//Lista de monedas disponibles
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
];

//Clase encargada de obtener los datos desde CoinGecko
class CoinData {
  //Metodo para obtener el precio de Bitcoin en la moneda seleccionada
  Future getDataPrice(String coin) async {
    //URL para obtener el precio de bitcoin en una moneda específica
    String url =
        'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=$coin';
    //Realiza la solicitud HTTP
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      //Si la respuesta es exitosa, obtenemos el cuerpo de la respuesta
      String data = response.body;
      //Decodificamos el JSON y extre el precio
      double price =
          jsonDecode(data)['bitcoin'][coin.toLowerCase()]?.toDouble() ?? 0.0;
      return price;
    } else {
      //Si la respuesta falla, mostramos el código de error
      print(response.statusCode);
    }
  }
}
