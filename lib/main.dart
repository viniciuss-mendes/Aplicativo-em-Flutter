import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // VARIAVEIS
  final _valorConta = TextEditingController();
  final _numPessoasNaoBebem = TextEditingController();
  final _numPessoasBebem = TextEditingController();
  final _valorTotalBebidasAlcoolicas = TextEditingController();
  double _SliderValue = 0;
  var _infoText = "Digite o valor total da conta:";
  var _infoTexto = "Digite a quantidade de pessoas:";
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Racha Conta"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetFields)
        ],
      ),
      body: _body(),
    );
  }

  // PROCEDIMENTO PARA LIMPAR OS CAMPOS
  void _resetFields(){
    _valorConta.text = "";
    _numPessoasBebem.text = "";
    _numPessoasNaoBebem.text = "";
    _valorTotalBebidasAlcoolicas.text = "";
    setState(() {
      _infoText = "Informe o valor da conta";
      _formKey = GlobalKey<FormState>();
    	});
    }

  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _editText("Valor total da conta", _valorConta),
              _editText("Número de pessoas que bebem", _numPessoasBebem),
              _editText("Número de pessoas que não bebem", _numPessoasNaoBebem),
              _editText("Valor somado das bebidas alcoólicas", _valorTotalBebidasAlcoolicas),
              Text("\nPorcentagem direcionada ao garçom:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
              Slider(value: _SliderValue,
                     min: 0,
                     max: 50,
                     divisions: 10,
                     label: _SliderValue.round().toString(),
                     onChanged: (double value){
                        setState((){
                          _SliderValue = value.roundToDouble();
                        });
                     }),
              _buttonCalcular(),
              _textInfo(),
            ],
          ),
        ));
  }

  // Widget text
  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 22,
        color: Colors.grey,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 22,
          color: Colors.black38,
        ),
      ),
    );
  }

  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  String _validate(String text, String field) {
    if (text.isEmpty) {
      return "$field";
    }
    return null;
  }

  // Widget button
  _buttonCalcular() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20),
      height: 50,
      child: RaisedButton(
        color: Colors.lightBlue,
        child:
        Text(
          "Calcular",
          style: TextStyle(
            color: Colors.black38,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
            _calculate();
          }
        },
      ),
    );
  }

  // PROCEDIMENTO PARA CALCULAR A DIVISÃO DA CONTA(SAIDINHA) ENTRE PESSOAS
  void _calculate(){
    setState(() {
      double valorGarcom = (_SliderValue/100)*double.parse(_valorConta.text);
      double _valorContaTotal = valorGarcom + double.parse(_valorConta.text);

      double ValorPessoasQueBebem = 0;
      double ValorPessoasQueNaoBebem = 0;

      if(double.parse(_numPessoasNaoBebem.text) == 0){
        ValorPessoasQueNaoBebem = 0;
      }else{
        ValorPessoasQueNaoBebem = _valorContaTotal / double.parse(_numPessoasNaoBebem.text);
      }
      if(double.parse(_numPessoasBebem.text) == 0){
          ValorPessoasQueBebem = 0;
      }else{
        double aux = double.parse(_valorTotalBebidasAlcoolicas.text) / double.parse(_numPessoasBebem.text);
        ValorPessoasQueNaoBebem = (_valorContaTotal / double.parse(_numPessoasBebem.text)) + aux;
      }

      String Result = "Valor total da Conta: R\$ " + _valorContaTotal.toStringAsPrecision(4) +
                      "\nGorjeta destinada ao garçom: R\$ " + valorGarcom.toStringAsPrecision(4) +
                      "\nValor individual por pessoa que ingere bebidas com alcool: R\$ " + ValorPessoasQueBebem.toStringAsPrecision(4) +
                      "\nValor individual por pessoa que não ingere bebidas com alcool: " + ValorPessoasQueNaoBebem.toStringAsPrecision(4);
      _infoText = Result;
    });
  }

  // // Widget textFimport 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // VARIAVEIS
  final _valorConta = TextEditingController();
  final _numPessoasNaoBebem = TextEditingController();
  final _numPessoasBebem = TextEditingController();
  final _valorTotalBebidasAlcoolicas = TextEditingController();
  double _SliderValue = 0;
  var _infoText = "Digite o valor total da conta:";
  var _infoTexto = "Digite a quantidade de pessoas:";
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Racha Conta"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetFields)
        ],
      ),
      body: _body(),
    );
  }

  // PROCEDIMENTO PARA LIMPAR OS CAMPOS
  void _resetFields(){
    _valorConta.text = "";
    _numPessoasBebem.text = "";
    _numPessoasNaoBebem.text = "";
    _valorTotalBebidasAlcoolicas.text = "";
    setState(() {
      _infoText = "";
      _formKey = GlobalKey<FormState>();
    });
  }

  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _editText("Valor total da conta", _valorConta),
              _editText("Número de pessoas que bebem", _numPessoasBebem),
              _editText("Número de pessoas que não bebem", _numPessoasNaoBebem),
              _editText("Valor somado (somente) das bebidas alcoolicas", _valorTotalBebidasAlcoolicas),
              Text("\nPorcentagem direcionada ao garcom:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
              Slider(value: _SliderValue,
                  min: 0,
                  max: 50,
                  divisions: 10,
                  label: _SliderValue.round().toString(),
                  onChanged: (double value){
                    setState((){
                      _SliderValue = value.roundToDouble();
                    });
                  }),
              _buttonCalcular(),
              _textInfo(),
            ],
          ),
        ));
  }

  // Widget text
  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 22,
        color: Colors.grey,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 22,
          color: Colors.black38,
        ),
      ),
    );
  }

  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  String _validate(String text, String field) {
    if (text.isEmpty) {
      return "$field";
    }
    return null;
  }

  // Widget button
  _buttonCalcular() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20),
      height: 40,
      child: RaisedButton(
        color: Colors.lightBlue,
        child:
        Text(
          "Calcular",
          style: TextStyle(
            color: Colors.black38,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
            _calculate();
          }
        },
      ),
    );
  }

  // PROCEDIMENTO PARA CALCULAR A DIVISÃO DA CONTA(SAIDINHA) ENTRE PESSOAS
  void _calculate(){
    setState(() {
      double valorGarcom = (_SliderValue/100)*double.parse(_valorConta.text);
      double _valorContaTotal = valorGarcom + double.parse(_valorConta.text);

      double ValorPessoasQueBebem = 0;
      double ValorPessoasQueNaoBebem = 0;

      if(double.parse(_numPessoasNaoBebem.text) == 0){
        ValorPessoasQueNaoBebem = 0;
      }else{
        ValorPessoasQueNaoBebem = (_valorContaTotal - double.parse(_valorTotalBebidasAlcoolicas.text)) / (double.parse(_numPessoasNaoBebem.text) + double.parse(_numPessoasBebem.text));
      }
      if(double.parse(_numPessoasBebem.text) == 0){
        ValorPessoasQueBebem = 0;
      }else{
        ValorPessoasQueBebem = (_valorContaTotal - ValorPessoasQueNaoBebem * double.parse(_numPessoasNaoBebem.text)) / double.parse(_numPessoasBebem.text);
      }

      String Result = "Valor total da Conta: R\$ " + _valorContaTotal.toStringAsPrecision(4) +
          "\nGorjeta destinada ao garçom: R\$ " + valorGarcom.toStringAsPrecision(4) +
          "\nValor individual (c/ bebida alcoólica): R\$ " + ValorPessoasQueBebem.toStringAsPrecision(4) +
          "\nValor individual(s/ bebida alcoólica): R\$ " + ValorPessoasQueNaoBebem.toStringAsPrecision(4);
      _infoText = Result;
    });
  }

  // // Widget textF
  _textInfo() {
    return Text(
      _infoText,
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.black, fontSize: 15.0),
    );
  }
}



  _textInfo() {
    return Text(
      _infoText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: 15.0),
    );
  }
}


