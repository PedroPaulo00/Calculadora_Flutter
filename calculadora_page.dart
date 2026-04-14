import 'package:calculadora_pet/pages/operation_type.dart';
import 'package:calculadora_pet/widgets/buttom_widget.dart';
import 'package:flutter/material.dart';

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  late String displaynumber;

  void initState(){
    displaynumber='0';
    super.initState();
  }

  void setOperationType(OperationTypeEnum newType){
    setState(() {
      displaynumber += newType.symbol;
    });
  }

  void clearCalculator(){
    setState((){
      displaynumber = '0';
    });
  }

  void appendNumber(String stringNumber){
    setState(() {
      if(displaynumber == '0'){
        displaynumber = stringNumber;
      }else{
        displaynumber+= stringNumber;
      }
    });
  }

  void removeNumber(){
    if(displaynumber.length <=1){
      displaynumber = '0';
    }
    else{
      displaynumber = displaynumber.substring(0, displaynumber.length-1);
    }
  }

  List<double> parseNumbers(String expression){
    RegExp regExp = RegExp(r'[0-9]+\.?[0-9]*');

    var matches = regExp.allMatches(expression);

    List<double> numbers = [];

    for(var match in matches){
      String numberText = match.group(0)!;
      numbers.add(double.parse(numberText));
    }

    return numbers;
  }

  List<OperationTypeEnum> getOperators(String expression){
    final expression1 = expression.characters.where(
      (x) => OperationTypeEnum.values.any((op)=> op.symbol ==x),
    );

    return expression1.map((x)=> OperationTypeEnum.values.firstWhere((op)=> op.symbol ==x)).toList();
  }

  void calculate(){
    String expression = displaynumber.replaceAll(',', '.');

    List<double> numbers = parseNumbers(expression);
    List<OperationTypeEnum> operations = getOperators(expression);

    resolvePriorityOperations(numbers, operations);
    final result = resolveAdditionAndSubtraction(numbers, operations);
    setState(() {
      displaynumber = result.toString().replaceAll('.', ',');
    });
  }

  void resolvePriorityOperations(List<double> numbers, List<OperationTypeEnum> operators,){
    int index = 0;

    while(index < operators.length){
      if(operators[index] == OperationTypeEnum.multiplication){
        numbers[index] = numbers[index] * numbers[index+1];
        numbers.removeAt(index+1);
        operators.removeAt(index);
      }else if(operators[index] == OperationTypeEnum.division){
        numbers[index] = numbers[index]/numbers[index+1];
        numbers.removeAt(index+1);
        operators.removeAt(index);
      }else{
        index++;
      }
    }
  }

  double resolveAdditionAndSubtraction(
    List<double> numbers,
    List<OperationTypeEnum> operators,
  ){
    int index = 0;

    while(index<operators.length){
      if(operators[index] == OperationTypeEnum.addition){
        numbers[index] = numbers[index] + numbers[index+1];
        numbers.removeAt(index+1);
        operators.removeAt(index);
      }else if(operators[index] == OperationTypeEnum.subtraction){
        numbers[index] = numbers[index] - numbers[index+1];
        numbers.removeAt(index+1);
        operators.removeAt(index);
      }
    }

    return numbers[0];
  }

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
                displaynumber,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
            ),
            SizedBox(height: 20,),
            Column(
              children: [
                Row(
                  children: [
                    ButtomWidget(text: "C", onPressed: (){
                      clearCalculator();
                    }, color: Colors.red,),
                    ButtomWidget(text: "\u232b", onPressed: (){
                      removeNumber();
                    }, color: Colors.orange),
                    ButtomWidget(text: '÷', onPressed: (){
                      setOperationType(OperationTypeEnum.division);
                    }, color: Colors.blue, textColor: Colors.white),
                  ],
                ),
                Row(children: [
                  ButtomWidget(text: '7', onPressed: (){
                    appendNumber('7');
                  }),
                  ButtomWidget(text: '8', onPressed: (){
                    appendNumber('8');
                  }),
                  ButtomWidget(text: '9', onPressed: (){
                    appendNumber('9');
                  }),
                  ButtomWidget(text: "X", onPressed: (){
                    setOperationType(OperationTypeEnum.multiplication);
                  }, color: Colors.blue, textColor: Colors.white),
                ],
                ),
                Row(children: [
                  ButtomWidget(text: '4', onPressed: (){
                    appendNumber('4');
                  }),
                  ButtomWidget(text: '5', onPressed: (){
                    appendNumber('5');
                  }),
                  ButtomWidget(text: '6', onPressed: (){
                    appendNumber('6');
                  }),
                  ButtomWidget(text: "-", onPressed: (){
                    setOperationType(OperationTypeEnum.subtraction);
                  }, color: Colors.blue, textColor: Colors.white),
                ],
                ),
                Row(children: [
                  ButtomWidget(text: '1', onPressed: (){
                    appendNumber('1');
                  }),
                  ButtomWidget(text: '2', onPressed: (){
                    appendNumber('2');
                  }),
                  ButtomWidget(text: '3', onPressed: (){
                    appendNumber('3');
                  }),
                  ButtomWidget(text: "+", onPressed: (){
                    setOperationType(OperationTypeEnum.addition);
                  }, color: Colors.blue, textColor: Colors.white),
                ],
                ),
                Row(children: [
                  ButtomWidget(text: '0', onPressed: (){
                    appendNumber('0');
                  }),
                  ButtomWidget(text: ',', onPressed: (){
                    appendNumber(',');
                  }),
                  ButtomWidget(text: "=", onPressed: (){
                    calculate();
                  }, color: Colors.green),
                ],)
              ],
            )
        ],)
    );
  }
}
