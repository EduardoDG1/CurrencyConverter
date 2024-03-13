import 'package:currency_converter/Models/Currency.dart';
import 'package:currency_converter/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Currency? dpValue1;
  Currency? dpValue2;
  List<Currency> dpItems1 = [];
  List<Currency> dpItems2 = [];
  TextEditingController controller1 = TextEditingController(text: 0.toStringAsFixed(2));
  TextEditingController controller2 = TextEditingController(text: 0.toStringAsFixed(2));
  String prefix1 = "R\$";
  String prefix2 = "\$";
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "\$CONVERTER\$",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade900,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      backgroundColor: Colors.grey,
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    Text(
                      "Loading data...",
                      style: TextStyle(color: Colors.green, fontSize: 25),
                    )
                  ],
                ));
              default:
                if (snapshot.hasError) {
                  return const Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Error loading data!",
                        style: TextStyle(color: Colors.red, fontSize: 25),
                      ),
                    ],
                  ));
                } else {
                  var currency = snapshot.data!["results"]["currencies"];
                  if(dpItems1.isEmpty && dpItems2.isEmpty){
                    dpItems1 = DropDownItems(currency);
                    dpItems2 = DropDownItems(currency);

                    dpValue1 = dpItems1.firstWhere((element) => element.key == "BRL");
                    dpValue2 = dpItems2.firstWhere((element) => element.key == "USD");
                  }

                  return ListView(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Icon(Icons.monetization_on_outlined,
                              color: Colors.amber, size: 300),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(20)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 70,
                            width: 280,
                            child: TextField(
                              controller: controller1,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                prefixStyle: const TextStyle(
                                    color: Colors.green, fontSize: 25),
                                prefixText: prefix1,
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.purple, width: 3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.green, width: 3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.green, width: 3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              style: TextStyle(fontSize: 25),
                              onTap: (){
                                controller1.selection = TextSelection(baseOffset: 0, extentOffset: controller1.value.text.length);
                              },
                              onChanged: (String str) {
                                if(dpValue1!.key == "BRL" && dpValue2!.key != "BRL"){
                                  value = double.parse(str);
                                  if(dpValue2!.key == "BTC"){
                                    controller2.text = (value/dpValue2!.value!).toStringAsFixed(8);
                                  }else{
                                    controller2.text = (value/dpValue2!.value!).toStringAsFixed(2);
                                }
                                }else if(dpValue1!.key != "BRL" && dpValue2!.key == "BRL"){
                                  value = double.parse(str);
                                  controller2.text = (value * dpValue1!.value!).toStringAsFixed(4);
                                } else if(dpValue1!.key != "BRL" && dpValue2!.key != "BRL"){
                                  value = double.parse(str);
                                  if(dpValue2!.key == "BTC"){
                                    controller2.text = (value * dpValue1!.value! / dpValue2!.value!).toStringAsFixed(9);
                                  }else{
                                    controller2.text = (value * dpValue1!.value! / dpValue2!.value!).toStringAsFixed(4);
                                  }
                                } else if(dpValue1!.key == "BRL" && dpValue2!.key == "BRL"){
                                  controller2.text = (value * 1).toStringAsFixed(2);
                                }
                              },
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(5)),
                          Expanded(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.green, width: 3),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 70,
                                child: DropdownMenu(
                                  initialSelection: dpValue1,
                                  dropdownMenuEntries: ConvertToDropDown(dpItems1),
                                  textStyle: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                  ),
                                  onSelected: (Currency? value) {
                                    dpValue1 = value!;
                                    controller1.text = 0.toStringAsFixed(2);
                                    controller2.text = 0.toStringAsFixed(2);

                                    switch (dpValue1!.key) {
                                      case "ARS":
                                        prefix1 = "\$";
                                        setState(() {});
                                      case "AUD":
                                        prefix1 = "AU\$";
                                        setState(() {});
                                      case "BTC":
                                        prefix1 = "₿";
                                        setState(() {});
                                      case "CAD":
                                        prefix1 = "C\$";
                                        setState(() {});
                                      case "CNY":
                                        prefix1 = "元/¥";
                                        setState(() {});
                                      case "EUR":
                                        prefix1 = "€";
                                        setState(() {});
                                      case "GBP":
                                        prefix1 = "£";
                                        setState(() {});
                                      case "JPY":
                                        prefix1 = "¥";
                                        setState(() {});
                                      case "USD":
                                        prefix1 = "\$";
                                        setState(() {});
                                      default:
                                        prefix1 = "R\$";
                                        setState(() {});
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(20)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 70,
                            width: 280,
                            child: TextField(
                              readOnly: true,
                              controller: controller2,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                prefixStyle: const TextStyle(
                                    color: Colors.green, fontSize: 25),
                                prefixText: prefix2,
                                counterText: "",
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.purple, width: 3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.green, width: 3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.green, width: 3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(5)),
                          Expanded(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.green, width: 3),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 70,
                                child: DropdownMenu(
                                  initialSelection: dpValue2,
                                  dropdownMenuEntries: ConvertToDropDown(dpItems2),
                                  textStyle: const TextStyle(
                                      color: Colors.green, fontSize: 20),
                                  onSelected: (Currency? value) {
                                    dpValue2 = value!;
                                    controller1.text = 0.toStringAsFixed(2);
                                    controller2.text = 0.toStringAsFixed(2);

                                    switch (dpValue2!.key) {
                                      case "ARS":
                                        prefix2 = "\$";
                                        setState(() {});
                                      case "AUD":
                                        prefix2 = "AU\$";
                                        setState(() {});
                                      case "BTC":
                                        prefix2 = "₿";
                                        setState(() {});
                                      case "CAD":
                                        prefix2 = "C\$";
                                        setState(() {});
                                      case "CNY":
                                        prefix2 = "元/¥";
                                        setState(() {});
                                      case "EUR":
                                        prefix2 = "€";
                                        setState(() {});
                                      case "GBP":
                                        prefix2 = "£";
                                        setState(() {});
                                      case "JPY":
                                        prefix2 = "¥";
                                        setState(() {});
                                      case "BRL":
                                        prefix2 = "R\$";
                                        setState(() {});
                                      default:
                                        prefix2 = "\$";
                                        setState(() {});
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
            }
          }),
    );
  }
}

List<Currency> DropDownItems(Map<String, dynamic> map) {
  List<Currency> menuItems = [];

  map.forEach((key, value) {
    if (key != "source") {
      menuItems
          .add(Currency(key: key, name: value["name"], value: value["buy"]));
    }
  });

  menuItems.add(Currency(key: "BRL", name: "Real", value: 1));

  menuItems.sort((a, b) {
    return a.key!.compareTo(b.key!);
  });

  return menuItems;
}

List<DropdownMenuEntry<Currency>> ConvertToDropDown(List<Currency> list) {
  List<DropdownMenuEntry<Currency>> listDP = [];

  list.forEach((element) {
    listDP.add(DropdownMenuEntry(
        value: element,
        label: element.key!,
        style: ButtonStyle(alignment: Alignment.center)));
  });

  return listDP;
}
