import 'package:flutter/material.dart';

class PriceDropDownButton extends StatelessWidget {
  final String? selectedCity;
  final List<MapEntry<String, num>> petrolData;
  final num? price;
  final Map<String, num> data;
  final void Function(String?) onChanged;
  const PriceDropDownButton(
    {
      super.key,
      required this.data,
      required this.selectedCity,
      required this.petrolData,
      required this.price,
      required this.onChanged,
    }
  );

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          DropdownButton(
            value: selectedCity,
            isExpanded: true,
            hint:
                const Text("Select The City for petrol price."),
            items: petrolData.map((e) {
              final key = e.key;
              final value = e.value;
              return DropdownMenuItem(
                value: key,
                child: Text("$key : $value"),
              );
            }).toList(),
            onChanged: (value) => onChanged(value),
          )
        ],
      );
  }
}