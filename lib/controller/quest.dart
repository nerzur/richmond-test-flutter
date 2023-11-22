class Quest{
  int _value;
  String _text;

  Quest(this._value, this._text);

  String get text => _text;

  set text(String value) {
    _text = value;
  }

  int get value => _value;

  set value(int value) {
    _value = value;
  }
}