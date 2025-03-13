part of 'base_api_repo.dart';

class MockApiRepo extends BaseApiRepo {
  Future<APIResponse> getJobs() async {
    return await NetworkingService().getAPICall(endpoint: Endpoints.getJobs);
  }
}
