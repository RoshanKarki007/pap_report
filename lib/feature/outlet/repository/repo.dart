import 'package:pap_report/constants/apis.dart';
import 'package:pap_report/constants/request_type.dart';
import 'package:pap_report/feature/outlet/model/outlet_model.dart';
import 'package:pap_report/utils/api_client.dart';
import 'package:pap_report/utils/api_exceptions.dart';

class OutletRepo {
  final ApiClient _client = ApiClient.instance;
  OutletRepo();
  Future<OutletModel> getoutlet() async {
    try {
      var response = await _client.request(
          requestType: RequestType.post, url: ApiConstants.getOutletUrl);
      return OutletModel.fromJson(response.data);
    } catch (ex) {
      throw ApiException.getApiException(ex);
    }
  }
}
