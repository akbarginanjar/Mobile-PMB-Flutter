import 'package:get/get.dart';
import 'package:pmb_mobile/utils/base.dart';

class MahasiswaService extends GetConnect implements GetxService {
  Future<Response> listPendaftaran(params) {
    return get('${Base.url}/api/mahasiswa/pending', query: params);
  }

  Future<Response> accMahasiswa(id, body) {
    return put('${Base.url}/api/mahasiswa/acc/$id', body);
  }

  Future<Response> nonAccMahasiswa(id, body) {
    return put('${Base.url}/api/mahasiswa/non-acc/$id', body);
  }

  Future<Response> listMahasiswa(params) {
    return get('${Base.url}/api/mahasiswa-all', query: params);
  }

  Future<Response> detailCekMahasiswa(id) {
    return get('${Base.url}/api/identitas-mahasiswa/$id');
  }

  Future<Response> dashboardAdmin(id) {
    return get('${Base.url}/api/mahasiswa-dashboard');
  }
}
