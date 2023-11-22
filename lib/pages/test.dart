import 'package:flutter/material.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:richmond_test/controller/quest.dart';
import 'package:richmond_test/controller/value.dart';
import 'package:richmond_test/widgets/custom_widgets.dart';

class TestsPage extends StatefulWidget {
  const TestsPage({Key? key}) : super(key: key);

  @override
  State<TestsPage> createState() => _TestsPageState();
}

class _TestsPageState extends State<TestsPage> {
  final List<Value<int>> _values = [
    Value(0),
    Value(0),
    Value(0),
    Value(0),
  ];

  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("Test de Richmond"),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: h1("Formulario"),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              "Para responder el siguiente cuestionario seleccione de los siguientes elementos la respuesta que considere correcta",
              textAlign: TextAlign.justify,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              testCard(<Widget>[
                h2("Le gustaría dejar de fumar?"),
                const SizedBox(
                  height: 10,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: questValues([
                      Quest(0, "No"),
                      Quest(1, "Si"),
                    ], _values[0], this)),
              ], context),
              testCard(<Widget>[
                h2("Cuánto interés tiene en dejarlo?"),
                const SizedBox(
                  height: 10,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: questValues([
                      Quest(0, "Ninguno"),
                      Quest(1, "Algo"),
                      Quest(2, "Bastante"),
                      Quest(3, "Mucho"),
                    ], _values[1], this)),
              ], context),
              testCard(<Widget>[
                Container(
                    padding: EdgeInsets.all(5),
                    child: h2(
                        "Intentará dejar de fumar en las próximas dos semanas?")),
                const SizedBox(
                  height: 10,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: questValues([
                      Quest(0, "No"),
                      Quest(1, "Quizás"),
                      Quest(2, "Si"),
                      Quest(3, "Definitivamente"),
                    ], _values[2], this)),
              ], context),
              testCard(<Widget>[
                Container(
                    padding: EdgeInsets.all(5),
                    child: h2(
                        "Cree que en los próximos 6 meses será un exfumador")),
                const SizedBox(
                  height: 10,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: questValues([
                      Quest(0, "No"),
                      Quest(1, "Quizás"),
                      Quest(2, "Si"),
                      Quest(3, "Definitivamente"),
                    ], _values[3], this)),
              ], context),
            ],
          )),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ProgressButton.icon(
                iconedButtons: {
                  ButtonState.idle: IconedButton(
                      text: 'Procesar',
                      icon: const Icon(Icons.send, color: Colors.white),
                      color: Colors.blue.shade500),
                  ButtonState.loading: IconedButton(
                      text: 'Cargando', color: Colors.blueGrey.shade700),
                  ButtonState.fail: IconedButton(
                      text: 'Fallido',
                      icon: const Icon(Icons.cancel, color: Colors.white),
                      color: Colors.red.shade300),
                  ButtonState.success: IconedButton(
                      text: 'Satisfactorio',
                      icon: const Icon(Icons.check_circle, color: Colors.white),
                      color: Colors.green.shade400)
                },
                onPressed: () {
                  switch (stateTextWithIcon) {
                    case ButtonState.idle:
                      stateTextWithIcon = ButtonState.loading;
                      Future.delayed(
                        const Duration(seconds: 5),
                        () {
                          setState(
                            () {
                              int result = 0;
                              _values.forEach((element) {
                                result += element.val;
                              });
                              Color background = Colors.green;
                              String resultado = "Bien";
                              if (result < 8) {
                                background = Colors.red;
                                resultado = "Mal";
                              } else if (result >= 8 && result < 10) {
                                background = Colors.yellow;
                                resultado = "Regular";
                              }
                              stateTextWithIcon = ButtonState.idle;
                              showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      color: background,
                                      child: Padding(
                                        padding: EdgeInsets.all(40),
                                        child: Text("Resultado: $resultado",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 35,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                    );
                                  });
                            },
                          );
                        },
                      );

                      break;
                    case ButtonState.loading:
                      break;
                    case ButtonState.success:
                      stateTextWithIcon = ButtonState.idle;
                      break;
                    case ButtonState.fail:
                      break;
                  }
                  setState(
                    () {
                      stateTextWithIcon = stateTextWithIcon;
                    },
                  );
                },
                state: stateTextWithIcon),
          )
          // SizedBox(height: 40),
        ],
      ),
    );
  }
}
