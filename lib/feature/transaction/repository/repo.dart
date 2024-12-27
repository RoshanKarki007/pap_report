import 'package:pap_report/constants/apis.dart';
import 'package:pap_report/constants/request_type.dart';
import 'package:pap_report/feature/transaction/model/transaction_model.dart';
import 'package:pap_report/utils/api_client.dart';
import 'package:pap_report/utils/api_exceptions.dart';

class TransactionRepo {
  final ApiClient _client = ApiClient.instance;
  TransactionRepo();
  Future<TransactionModel> getTransaction() async {
    try {
      var response = await _client.request(
          requestType: RequestType.post, url: ApiConstants.getTransactionUrl);
      return TransactionModel.fromJson(response.data);
    } catch (ex) {
      throw ApiException.getApiException(ex);
    }
  }
}
