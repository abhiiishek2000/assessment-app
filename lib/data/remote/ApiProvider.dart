import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import '../../constants.dart';
import 'CustomException.dart';


class ApiProvider {
  Future<dynamic> post(BuildContext context,String url,Map<String,String> map) async {
    var mapHeader = new Map<String, String>();
    mapHeader['Accept'] = "application/json";
    var responseJson;
    try {
      var uri =  Uri.https(BaseUrl, PathExtender + url, map);
      print("request: $uri $url - $map");
      final response = await http.post(uri,body: map,headers: mapHeader);
      print("response:$uri $url - $map ${response.body}");
      responseJson = _response(context,response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> get(BuildContext context,String url,Map<String,String> map) async {
    var mapHeader = new Map<String, String>();
    mapHeader['Accept'] = "application/json";
    print("param : $mapHeader");
    var responseJson;
    try {
      var uri =  Uri.https(BaseUrl ,PathExtender+url,map);
      print("request: $uri $url - $mapHeader");
      final response = await http.get(uri,headers: mapHeader);
      print("response: $uri $url - $map ${response.body}");
      responseJson = _response(context,response);
    } on SocketException {

      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
  Future<dynamic> delete(BuildContext context,String url,Map<String,String> map) async {
    var mapHeader = new Map<String, String>();
    mapHeader['Accept'] = "application/json";
    var responseJson;
    try {
      var uri = Uri.https(BaseUrl ,PathExtender+url,map);
      print("request: $uri $url - $map");
      final response = await http.delete(uri,body: map,headers: mapHeader);
      print("response: $uri $url - $map ${response.body}");
      responseJson = _response(context,response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }



  dynamic _response(BuildContext context, http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 404:
        throw InvalidInputException(response.body.toString());
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw BadRequestException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw BadRequestException(response.body.toString());
      case 202:
        throw BadRequestException(response.body.toString());
      case 503:
        throw BadRequestException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response
                .statusCode}');
    }
  }
}
