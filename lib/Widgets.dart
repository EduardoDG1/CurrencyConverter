import 'package:flutter/material.dart';

Widget CustomTextField() {
  return Container(
    height: 65,
    width: 265,
    child: const TextField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      style: TextStyle(color: Colors.green),
    ),
  );
}

Widget CustomDropDownButton(String dropDownValue, List<String> values) {
  return Expanded(
    child: Container(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField(
          isExpanded: true,
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),

            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10)),

            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          dropdownColor: Colors.white,
          onChanged: (String? value) {
            dropDownValue = value!;
          },
          items: values.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  Text(
                    value,
                    style: const TextStyle(color: Colors.green, fontSize: 20),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10))
                ],
              ),
            );
          }).toList(),
        ),
      ),
    )
  );
}
