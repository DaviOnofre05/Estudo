import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String coalesceStr(
  List<String?> lst, {
  String? prefix,
  String? sufix,
  String onError = "",
}) {
  for (var s in lst) {
    if (s != null && s.trim().isNotEmpty) {
      if (prefix != null) {
        if (sufix != null) {
          return prefix + s + sufix;
        }
        return prefix + s;
      }
      if (sufix != null) {
        return s + sufix;
      }
      return s;
    }
  }
  return onError; // se não tem ninguém válido, não tem sufixo nem prefixo
}

String idMap(String? campo, Map<String, String> map, String defaultValue) {
  if (campo != null) {
    campo = campo.toUpperCase();
    for (var i in map.entries) {
      if (campo == i.key.toUpperCase()) {
        return i.value;
      }
    }
  }
  return defaultValue;
}

String? unformatNumber(String? formatedNumber) {
  if (formatedNumber == null) return null;
  const stripRegex = r'[^\d]';
  RegExp regExp = RegExp(stripRegex);
  return formatedNumber.replaceAll(regExp, "");
}

int _verifierDigitCPF(String cpf) {
  var numbers = cpf.characters.map((e) => int.parse(e)).toList();

  int modulus = numbers.length + 1;

  List<int> multiplied = [];

  for (var i = 0; i < numbers.length; i++) {
    multiplied.add(numbers[i] * (modulus - i));
  }

  int mod = multiplied.reduce((buffer, number) => buffer + number) % 11;

  return (mod < 2 ? 0 : 11 - mod);
}

int _verifierDigitCNPJ(String cnpj) {
  int index = 2;

  List<int> reverse = cnpj.split("").map((s) => int.parse(s)).toList().reversed.toList();

  int sum = 0;

  for (var number in reverse) {
    sum += number * index;
    index = (index == 9 ? 2 : index + 1);
  }

  int mod = sum % 11;

  return (mod < 2 ? 0 : 11 - mod);
}

bool validaCPF(String? cpf) {
  if (cpf == null || cpf.isEmpty) {
    return false;
  }

  // Retira formatação
  var data = unformatNumber(cpf) ?? "";

  // Retira zeros a esquerda
  while (data.isNotEmpty && data.startsWith('0')) {
    data = data.substring(1);
  }

  //Verifica tamanho máximo
  if (data.length > 11 || data.isEmpty) {
    return false;
  }

  // Formata para 11 caracteres
  data = data.padLeft(11, "0");

  // Calcula dígitos
  String numbers = data.substring(0, 9);
  numbers += _verifierDigitCPF(numbers).toString();
  numbers += _verifierDigitCPF(numbers).toString();
  return numbers.substring(numbers.length - 2) == data.substring(data.length - 2);
}

String? formatCPF(String? nr) {
  if (nr == null) return null; //tratamento de nulo é nulo (Padrão acordado)

  //Tira formatação prévia e formata para 11 digitos
  String ts = unformatNumber(nr)!.padLeft(11, "0");

  //Formata pontuação
  return "${ts.substring(0, 3)}.${ts.substring(3, 6)}.${ts.substring(6, 9)}-${ts.substring(9, 11)}";
}

bool validaCNPJ(String? cnpj) {
  if (cnpj == null || cnpj.isEmpty) {
    return false;
  }

  // Retira formatação
  var data = unformatNumber(cnpj) ?? "";

  // Retira zeros a esquerda
  while (data.isNotEmpty && data.startsWith('0')) {
    data = data.substring(1);
  }

  //Verifica tamanho máximo
  if (data.length > 14 || data.isEmpty) {
    return false;
  }

  // Formata para 14 caracteres
  data = data.padLeft(14, "0");

  // Calcula dígitos
  String numbers = data.substring(0, 12);
  numbers += _verifierDigitCNPJ(numbers).toString();
  numbers += _verifierDigitCNPJ(numbers).toString();
  return numbers.substring(numbers.length - 2) == data.substring(data.length - 2);
}

String? formatCNPJ(String? nr) {
  if (nr == null) return null; //tratamento de nulo é nulo (Padrão acordado)

  //Tira formatação prévia e formata para 14 digitos
  String ts = unformatNumber(nr)!.padLeft(14, "0");

  //Formata pontuação
  return "${ts.substring(0, 2)}.${ts.substring(2, 5)}.${ts.substring(5, 8)}/${ts.substring(8, 12)}-${ts.substring(12, 14)}";
}

String? formatCep(String? cep) {
  if (cep == null) return null; //tratamento de nulo é nulo (Padrão acordado)
  var f = unformatNumber(cep);
  if (f == null || f.length < 8) return null;
  return "${f.substring(0, 5)}-${f.substring(5, 8)}";
}

double? str2Double(String? value, [double? defaultValue]) {
  if (value == null) return defaultValue;
  value = value.replaceAll(".", "").replaceAll(",", ".");
  return double.tryParse(value) ?? defaultValue;
}

int? str2Int(String? value, [int? defaultValue]) {
  if (value == null) return defaultValue;
  return int.tryParse(value) ?? defaultValue;
}

DateTime? str2Date(String? value, [DateTime? defaultValue]) {
  if (value == null) return defaultValue;
  try {
    var arr = value.trim().split(RegExp("\\D+")); //qualquer coisa não numérica vira separador

    var cl = DateTime.now();

    int day = 0;
    int month = cl.month;
    int year = cl.year;
    int hour = 0;
    int minute = 0;
    int second = 0;
    int milisecond = 0;

    if (arr.length == 1 && arr[0].length == 8) {
      year = int.parse(arr[0].substring(4, 8));
      month = int.parse(arr[0].substring(2, 4));
      day = int.parse(arr[0].substring(0, 2));
    } else if (arr.length == 1 && arr[0].length == 6) {
      year = int.parse(arr[0].substring(4, 6));
      month = int.parse(arr[0].substring(2, 4));
      day = int.parse(arr[0].substring(0, 2));
    } else if (arr.length == 1 && arr[0].length == 4) {
      month = int.parse(arr[0].substring(2, 4));
      day = int.parse(arr[0].substring(0, 2));
    } else {
      if (arr.length >= 7) {
        // somente 3 primeiros (limita a milisegundos caso seja microsegundos ou fração)
        var mils = arr[6];
        if (mils.length > 3) mils.substring(0, 3);
        milisecond = int.parse(mils);
      }
      if (arr.length >= 6) {
        second = int.parse(arr[5]);
      }
      if (arr.length >= 5) {
        minute = int.parse(arr[4]);
      }
      if (arr.length >= 4) {
        hour = int.parse(arr[3]);
      }
      if (arr.length >= 3) {
        year = int.parse(arr[2]);
      }
      if (arr.length >= 2) {
        month = int.parse(arr[1]);
      }
      if (arr.isNotEmpty) {
        day = int.parse(arr[0]);
      } else {
        return defaultValue;
      }
    }

    //trata yyyy_mm_dd_hh_mm_ss
    if (day > 1000 && year <= 31) {
      int swap = day;
      day = year;
      year = swap;
    }

    if (year < 50) year += 2000;
    if (year >= 50 && year < 100) year += 1900;
    if (year < 1900 || month < 0 || day < 1 || day > 31 || month > 12 || year > 2999) {
      return defaultValue;
    }

    return DateTime(year, month, day, hour, minute, second, milisecond);
  } catch (_) {
    return defaultValue;
  }
}

TimeOfDay? str2Time(String? value, [TimeOfDay? defaultValue]) {
  if (value == null) return defaultValue;
  try {
    var arr = value.trim().split(RegExp("\\D+")); //qualquer coisa não numérica vira separador

    // OBS: second, milisecond estão sendo ignorados pelo Dart
    int hour = 0;
    int minute = 0;
    // int second = 0;
    // int milisecond = 0;

    if (arr.length == 1 && arr[0].length == 6) {
      // second = int.parse(arr[0].substring(4, 6));
      minute = int.parse(arr[0].substring(2, 4));
      hour = int.parse(arr[0].substring(0, 2));
    } else if (arr.length == 1 && arr[0].length == 4) {
      minute = int.parse(arr[0].substring(2, 4));
      hour = int.parse(arr[0].substring(0, 2));
    } else {
      // if (arr.length >= 4) {
      //   // somente 3 primeiros (limita a milisegundos caso seja microsegundos ou fração)
      //   var mils = arr[3];
      //   if (mils.length > 3) mils.substring(0, 3);
      //   milisecond = int.parse(mils);
      // }
      // if (arr.length >= 3) {
      //   second = int.parse(arr[2]);
      // }
      if (arr.length >= 2) {
        minute = int.parse(arr[1]);
      }
      if (arr.isNotEmpty) {
        hour = int.parse(arr[0]);
      } else {
        return defaultValue;
      }
    }

    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) {
      return defaultValue;
    }

    return TimeOfDay(hour: hour, minute: minute);
  } catch (_) {
    return defaultValue;
  }
}

String formatTime(TimeOfDay date, [String format = "HH:mm"]) {
  var fullDt = DateTime(1970, 01, 01, date.hour, date.minute);
  return formatDate(fullDt, format);
}

String formatDate(DateTime date, [String format = "dd/MM/yyyy HH:mm:ss"]) {
  final f = DateFormat(format);
  return f.format(date);
}

String formatNumber(double value, [int decimal = 2, bool thSeparator = true]) {
  var p = thSeparator ? "#,###" : "####";
  if (decimal > 0) {
    p += ".${"0" * decimal}";
  }
  final f = NumberFormat(p, "pt_BR");
  return f.format(value);
}

String? reformatTime(String? date, [String format = "HH:mm"]) {
  var tm = str2Time(date);
  if (tm != null) {
    return formatTime(tm, format);
  }
  return null;
}

String? reformatDate(String? date, [String format = "dd/MM/yyyy HH:mm:ss"]) {
  var dt = str2Date(date);
  if (dt != null) {
    return formatDate(dt, format);
  }
  return null;
}

String? reformatNumber(String? value, [int decimal = 2, bool thSeparator = true]) {
  var vl = str2Double(value);
  if (vl != null) {
    return formatNumber(vl, decimal, thSeparator);
  }
  return null;
}

String? formatIdade(String? dataNascimento, String? dataHoje) {
  if (dataNascimento == null) return null;

  var data = str2Date(dataNascimento);
  var hoje = str2Date(dataHoje) ?? DateTime.now();
  var idade = "";
  //Se data é antes de hoje
  if (data != null && data.isBefore(hoje)) {
    var meses = (hoje.month - data.month) + ((hoje.year - data.year) * 12);
    var dias = (hoje.day - data.day);
    if (dias < 0) {
      meses--;
    }
    var anos = (meses / 12).floor();
    meses = meses % 12;
    idade = "${anos}a ${meses}m ";

    // Set state para atualizar o enabled de idade
    return idade;
  }

  return "";
}

bool validaCelular(String? celular) {
  if (celular == null || celular.isEmpty) {
    return false;
  }

  // Retira formatação
  var data = unformatNumber(celular) ?? "";

  //Verifica tamanho máximo
  if (data.length != 11) {
    return false;
  }

  String regexPatter = r'^\((?:[14689][1-9]|2[12478]|3[1234578]|5[1345]|7[134579])\) (?:[2-8]|9[1-9])[0-9]{3}\-[0-9]{4}$';
  var regExp = RegExp(regexPatter);
  if (regExp.hasMatch(celular)) {
    return true;
  }
  return false;
}

bool rangeModCross(double aIni, double aFim, double bIni, double bFim, double mod) {
  aIni %= mod;
  aFim %= mod;
  bIni %= mod;
  bFim %= mod;
  if (aIni > aFim) aFim += mod;
  if (bIni > bFim) bFim += mod;
  for (var i = -1; i <= 1; i++) {
    if (aIni < (bFim + (mod * i)) && aFim > (bIni + (mod * i))) return true;
  }
  return false;
}

bool rangeModHold(double outIni, double outFim, double inIni, double inFim, double mod) {
  outIni %= mod;
  outFim %= mod;
  inIni %= mod;
  inFim %= mod;
  if (outIni > outFim) outFim += mod;
  if (inIni > inFim) inFim += mod;
  for (var i = -1; i <= 1; i++) {
    if (outIni <= (inIni + (mod * i)) && outFim >= (inFim + (mod * i))) return true;
  }
  return false;
}
