import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform; //Detecta si el sistema es iOS o Android

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD'; //Moneda seleccionada por defecto
  double bitcoinPrice = 0.0; //Precio actual de 1 BTC

  CoinData coinData = CoinData(); //Instancia de la clase CoinData

  //Metodo para obtener el precio y actualizar la interfaz
  void updatePrice() async {
    double price = await coinData.getDataPrice(selectedCurrency);
    setState(() {
      bitcoinPrice = price;
    });
  }

  //Llamamos a updatePrice() cuando inicia la pantalla
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updatePrice();
  }

  //Metodo que obtiene los elementos del menú desplegable para Android
  DropdownButton<String> androidDropdown() {
    //Lista para guardar los ítems del menú
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem<String>(
        child: Text(currency), //Texto que se mostrará
        value:
            currency, //Valor asociado a ese ítem, que se usará cuando el usuario lo seleccione
      );
      //Agrega el nuevo ítem a la lista
      dropdownItems.add(newItem);
    }

    //Retornar el widget DropdownButton ya construido
    return DropdownButton<String>(
      value: selectedCurrency, //Valor actual seleccionado
      items: dropdownItems, //Lista de opciones
      onChanged: (value) {
        //Si se selecciona una nueva opción, actualizar el estado
        if (value != null) {
          setState(() {
            selectedCurrency = value;
          });
          updatePrice(); //Actualiza el precio cuando cambia la moneda
        }
      },
    );
  }

  //Metodo que construye el selector tipo rueda para iOS
  CupertinoPicker iOSPicker() {
    //Lista que almacenará los textos para mostrar en la rueda
    List<Text> pickerItems = [];

    //Llenar la lista con los nombres de las monedas
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
        });
        updatePrice(); //Actualiza el precio al cambiar la moneda
      },
      children: pickerItems, //Lista de widgets que se muestran en la rueda
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🤑 Coin Ticker')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Tarjeta que muestra el precio del Bitcoin
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ${bitcoinPrice.toStringAsFixed(2)} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          ),
          //Contenedor inferior con el selector de monedas (Android o iOS)
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            //Muestra el picker adecuado dependiendo del sistema operativo
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
