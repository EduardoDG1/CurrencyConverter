import 'package:currency_converter/Widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}







class _HomePageState extends State<HomePage> {
  
  List<String> list = ["teste1","teste2","teste3","teste4"];
  String dropDownValue = "";
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("\$Converter\$",textAlign: TextAlign.center, style: TextStyle(fontSize: 30, ),),
          ],
        ),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Icon(Icons.monetization_on_outlined, color: Colors.green, size: 350),
                ],
              ),
              Padding(padding: EdgeInsets.all(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextField(),
                  const Padding(padding: EdgeInsets.all(5)),
                  CustomDropDownButton(dropDownValue, list),
                ],
              ),
              const Padding(padding: EdgeInsets.all(15)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextField(),
                  const Padding(padding: EdgeInsets.all(5)),
                  CustomDropDownButton(dropDownValue, list),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}