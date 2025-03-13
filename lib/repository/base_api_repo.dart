import 'package:dio/dio.dart';
import 'package:joblisting/app/api/api_response.dart';
import 'package:joblisting/services/networking/endpoints.dart';
import 'package:joblisting/services/networking/networking.dart';

part 'mock_api_repo.dart';

class BaseApiRepo {
  Dio dio = Dio(BaseOptions(
    baseUrl: "https://67d17873825945773eb4734e.mockapi.io/api/vl1",
  ));
}
