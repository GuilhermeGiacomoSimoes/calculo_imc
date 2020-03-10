import "package:flutter/material.dart";

void main() {
  runApp(MaterialApp(
    home: Home()
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "informe seus dados";

  void _resetFields() {
      weightController.text = "";
      heightController.text = "";

      setState(() {
        _infoText = "informe seus dados";
      });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if(imc < 18.6)
        _infoText = "abaixo do peso (${imc.toStringAsPrecision(4)})";
      else if(imc < 24.9)
        _infoText = "peso idelal (${imc.toStringAsPrecision(4)})";
      else if(imc < 29.9)
        _infoText = "levemente acima do peso (${imc.toStringAsPrecision(4)})";
      else if(imc < 34.9)
        _infoText = "obesidade grau I (${imc.toStringAsPrecision(4)})";
      else if(imc < 39.9)
        _infoText = "obesidade grau II (${imc.toStringAsPrecision(4)})";
      else if(imc > 40)
        _infoText = "obesidade grau III (${imc.toStringAsPrecision(4)})";

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Icon(Icons.person_outline, size: 120, color: Colors.green),

              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso kg",
                    labelStyle: TextStyle(color: Colors.green)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
                controller: weightController,
                validator: (value) {
                  if(value.isEmpty){
                    return "insira seu peso";
                  }
                },
              ),

              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura cm",
                    labelStyle: TextStyle(color: Colors.green)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
                controller: heightController,
                validator: (value) {
                  if(value.isEmpty){
                    return "insira sua altura";
                  }
                },
              ),

              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      if(_formKey.currentState.validate())
                        _calculate();
                    },
                    child: Text("calcular", style: TextStyle(color: Colors.white, fontSize: 25),),
                    color: Colors.green,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(_infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}
