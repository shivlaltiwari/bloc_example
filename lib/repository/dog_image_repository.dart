
import 'package:template/api/api_client.dart';
import 'package:template/api/result.dart';

class DogRepository{
  ApiClient? apiClient;
  DogRepository(){
    apiClient = ApiClient();
  }
  Future<Result> fetchDogImage() async{
    var result = await apiClient!.getDogsImage();
    if (result.isSuccess()){
      return Result.success(result.getValue());
    }else{
      return Result.error(result.getErrorMsg());
    }
  }
}