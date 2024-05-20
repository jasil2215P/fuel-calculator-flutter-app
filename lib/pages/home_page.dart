import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fuel_calc/utils/drawer.dart';
import 'package:fuel_calc/model/get_prices.dart';
import 'package:fuel_calc/utils/custom_text_field.dart';
import 'package:fuel_calc/utils/petrol_prices_menu.dart';
import 'package:animate_do/animate_do.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Map<String, num>?>? _future;
  String? selectedCity;
  String value = "0";
  num? price;

  final mileageController = TextEditingController();
  final distanceController = TextEditingController();
  final priceController = TextEditingController();

  double totalPrice(TextEditingController mileageController,
      TextEditingController distanceController) {
    if (price == null) return 0;

    double? mileage = double.tryParse(
      mileageController.text.replaceAll(RegExp(r'[^0-9.]'), ''),
    );

    double? distance = double.tryParse(
      distanceController.text.replaceAll(RegExp(r'[^0-9.]'), ''),
    );

    if (mileage == null || distance == null) return 0.0;

    return (distance / mileage) * price!;
  }

  @override
  void initState() {
    _future = getLivePetrolCost();
    super.initState();
  }

  void calculatePrice() {
    setState(() {
      if (priceController.text.isNotEmpty) {
        price = double.parse(
          priceController.text.replaceAll(RegExp(r'[^0-9.]'), ''),
        );
      }
      value =
          totalPrice(mileageController, distanceController).toStringAsFixed(2);
    });
  }

  void onPriceValueChanged(String? value, Map<String, num> data) {
    debugPrint(value);
    debugPrint(price.toString());

    setState(() {
      selectedCity = value;
      price = data[selectedCity];
    });
  }

  Widget dataHandler(
      BuildContext context, AsyncSnapshot<Map<String, num>?> snapshot) {
    // If Data is still loading, display CircularProgressIndicator
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator(color: Colors.white);
    }

    if (snapshot.hasData) {
      final data = snapshot.data!;
      final petrolData = data.entries.toList();

      return FadeInUp(
        child: PriceDropDownButton(
          data: data,
          selectedCity: selectedCity,
          petrolData: petrolData,
          price: price,
          onChanged: (value) => onPriceValueChanged(value, data),
        ),
      );
    }
    return BounceInDown(
      delay: const Duration(milliseconds: 750),
      child: CustomTextField(
        controller: priceController,
        label: "Price per Litre",
        leadingIcon: Icons.gas_meter,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomeDrawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Fuel Calculator"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 200),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade600,
                spreadRadius: 1,
                blurRadius: 15,
                offset: const Offset(0, 15),
              )
            ],
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Column(
            children: <Widget>[
              BounceInDown(
                delay: const Duration(milliseconds: 200),
                child: CustomTextField(
                  controller: mileageController,
                  label: "Mileage of the vehicle in Km/L",
                  leadingIcon: Icons.local_gas_station,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BounceInDown(
                delay: const Duration(milliseconds: 500),
                child: CustomTextField(
                  controller: distanceController,
                  label: "Distance in Kilometer",
                  leadingIcon: Icons.map_rounded,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: _future,
                builder: (context, snapshot) => dataHandler(context, snapshot),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "Expected Fuel Price is : ",
                style: TextStyle(color: Colors.red[400]!),
              ),
              Text(
                "₹ $value",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 40,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: calculatePrice,
        label: const Text("Calculate"),
        icon: const Icon(Icons.calculate),
      ),
    );
  }
}
