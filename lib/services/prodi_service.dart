import 'package:get/get.dart';
import 'package:pmb_mobile/utils/base.dart';

class ProdiService extends GetConnect implements GetxService {
  Future<Response> prodi(params) {
    return get('${Base.url}/api/prodi', query: params);
  }

  Future<Response> tambahProdi(body) {
    return post('${Base.url}/api/_act_add_prodi', body);
  }
}
