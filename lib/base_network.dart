import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:coba/model/model_chara.dart';
import 'package:coba/model/model_weapon.dart';

class BaseNetwork {
  static final String baseUrl = 'https://api.genshin.dev';

  Future<List<dynamic>> getKarakter() async {
    var url = Uri.parse('$baseUrl/characters');
    var response = await http.get(url);

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    return data;
  }

  Future<List<dynamic>> getWeapon() async {
    var url = Uri.parse('$baseUrl/weapons');
    var response = await http.get(url);

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    return data;
  }

  Future<GenshinChara> getDetailKarakter(String name) async {
    var url = Uri.parse('$baseUrl/characters/$name');
    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    return GenshinChara.fromJson(data);
  }

  Future<WeaponModel> getDetailWeapon(String name) async {
    print(name);
    var url = Uri.parse('$baseUrl/weapons/$name');
    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    return WeaponModel.fromJson(data);
  }

  }

