import 'package:calculadora_pet/widgets/buttom_widget.dart';
import 'package:flutter/material.dart';

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            color: Colors.black12,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "0",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
            ),
            SizedBox(height: 20,),
            Column(
              children: [
                Row(
                  children: [
                    ButtomWidget(text: "C", onPressed: (){}, color: Colors.red,),
                    ButtomWidget(text: "\u232b", onPressed: (){}, color: Colors.orange),
                    ButtomWidget(text: '÷', onPressed: (){}, color: Colors.blue, textColor: Colors.white),
                  ],
                ),
                Row(children: [
                  ButtomWidget(text: '7', onPressed: (){}),
                  ButtomWidget(text: '8', onPressed: (){}),
                  ButtomWidget(text: '9', onPressed: (){}),
                  ButtomWidget(text: "X", onPressed: (){}, color: Colors.blue, textColor: Colors.white),
                ],
                ),
                Row(children: [
                  ButtomWidget(text: '4', onPressed: (){}),
                  ButtomWidget(text: '5', onPressed: (){}),
                  ButtomWidget(text: '6', onPressed: (){}),
                  ButtomWidget(text: "-", onPressed: (){}, color: Colors.blue, textColor: Colors.white),
                ],
                ),
                Row(children: [
                  ButtomWidget(text: '1', onPressed: (){}),
                  ButtomWidget(text: '2', onPressed: (){}),
                  ButtomWidget(text: '3', onPressed: (){}),
                  ButtomWidget(text: "+", onPressed: (){}, color: Colors.blue, textColor: Colors.white),
                ],
                ),
                Row(children: [
                  ButtomWidget(text: '0', onPressed: (){}),
                  ButtomWidget(text: ',', onPressed: (){}),
                  ButtomWidget(text: "=", onPressed: (){}, color: Colors.green),
                ],)
              ],
            )
        ],)
    );
  }
}