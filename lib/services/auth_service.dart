import 'package:get/get.dart';
import 'package:pmb_mobile/utils/base.dart';

class AuthServices extends GetConnect implements GetxService {
  Future<Response> login(body) {
    return post('${Base.url}/api/_act_login', body);
  }

  Future<Response> register(body) {
    return post('${Base.url}/api/_act_register', body);
  }
}
