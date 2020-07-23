class Empleado {
  int _uid;
  String _nombre;
  double _salario;

  Empleado(this._uid, this._nombre, this._salario);

  double get salario => _salario;

  set salario(double value) {
    _salario = value;
  }

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }

  int get uid => _uid;

  set uid(int value) {
    _uid = value;
  }
}
