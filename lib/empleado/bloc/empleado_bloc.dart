import 'dart:async';

import 'package:patron_bloc/empleado/model/empleado.dart';

class EmpleadoBloc {
  List<Empleado> _listaEmpleado = [
    Empleado(1, 'Pedro Jesus Hincapie', 555000.0),
    Empleado(2, 'Pedro Jesus Hincapie', 2000.0),
    Empleado(3, 'Pedro Jesus Hincapie', 3000.0),
    Empleado(4, 'Pedro Jesus Hincapie', 4000.2),
    Empleado(5, 'Pedro Jesus Hincapie', 4000.2),
    Empleado(6, 'Pedro Jesus Hincapie', 4000.2),
  ];

  //StreamController
  final _listaEmpleadosStremController = StreamController<List<Empleado>>();
  final _incremendarSalarioEmpleadosStremController =
      StreamController<Empleado>();
  final _decrementarSalarioEmpleadosStremController =
      StreamController<Empleado>();

  //Getter : Streams y Sinks
  //Lista empleados
  Stream<List<Empleado>> get listaEmpleadosStrem =>
      _listaEmpleadosStremController.stream;

  StreamSink<List<Empleado>> get listaEmpleadosSink =>
      _listaEmpleadosStremController.sink;

  //Incremento
  Stream<Empleado> get incremendarSalarioStrem =>
      _incremendarSalarioEmpleadosStremController.stream;

  StreamSink<Empleado> get incremendarSalarioSink =>
      _incremendarSalarioEmpleadosStremController.sink;

  //Decremento
  Stream<Empleado> get decrementarSalarioStrem =>
      _decrementarSalarioEmpleadosStremController.stream;

  StreamSink<Empleado> get decrementarSalarioSink =>
      _decrementarSalarioEmpleadosStremController.sink;

  //Constructor
  EmpleadoBloc() {
    _listaEmpleadosStremController.add(_listaEmpleado);

    _incremendarSalarioEmpleadosStremController.stream
        .listen(_incrementarSalario);

    _decrementarSalarioEmpleadosStremController.stream
        .listen(_decrementarSalario);
  }

  //Funciones principales
  void _decrementarSalario(Empleado empleado) {
    double salarioActual = empleado.salario;
    double salarioIncrement = salarioActual * 20 / 100;
    _listaEmpleado[empleado.uid - 1].salario = salarioActual - salarioIncrement;
    listaEmpleadosSink.add(_listaEmpleado);
  }

  void _incrementarSalario(Empleado empleado) {
    double salarioActual = empleado.salario;
    double salarioIncrement = salarioActual * 20 / 100;
    _listaEmpleado[empleado.uid - 1].salario = salarioActual + salarioIncrement;
    listaEmpleadosSink.add(_listaEmpleado);
  }

  //dispose
  void dispose() {
    _listaEmpleadosStremController.close();
    _decrementarSalarioEmpleadosStremController.close();
    _incremendarSalarioEmpleadosStremController.close();
  }
}
