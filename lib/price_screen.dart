import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/network.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

String selectedCurrency = 'USD';

class _PriceScreenState extends State<PriceScreen> {
  double price = 0.0;
  double ethPrice = 0.0;
  double ltcPrice = 0.0;
  @override
  void initState() {
    setData();
    super.initState();
  }

  void setData() async {
    PriceData priceData = PriceData();
    price = await priceData.getData(selectedCurrency, 'BTC');
    ethPrice = await priceData.getData(selectedCurrency, 'ETH');
    ltcPrice = await priceData.getData(selectedCurrency, 'LTC');
    debugPrint("$price");
    debugPrint("$ethPrice");
    debugPrint("$ltcPrice");
    setState(() {
      price;
      ethPrice;
      ltcPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildPadding('1 BTC = ${price.toStringAsFixed(2)} $selectedCurrency'),
          buildPadding(
              '1 ETH = ${ethPrice.toStringAsFixed(2)} $selectedCurrency'),
          buildPadding(
              '1 LTC = ${ltcPrice.toStringAsFixed(2)} $selectedCurrency'),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
                value: selectedCurrency,
                items: currenciesList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCurrency = value!;
                    setData();
                  });
                }),
          )
        ],
      ),
    );
  }

  Padding buildPadding(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 28),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
