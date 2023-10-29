import 'package:dartz/dartz.dart';
import 'package:flutter_siakad_app/common/constants/variables.dart';
import 'package:flutter_siakad_app/data/models/request/auth_request_model.dart';
import 'package:flutter_siakad_app/data/models/respone/auth_response_model.dart';

import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      AuthRequestModel requestModel) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final respone = await http.post(
      Uri.parse('${Variables.baseUrl}/api/login'),
      headers: headers,
      body: requestModel.toJson(),
    );

    if (respone.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(respone.body));
    } else {
      return const Left('server error');
    }
  }
}
