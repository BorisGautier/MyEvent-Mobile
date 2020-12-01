import 'package:chopper/chopper.dart';
import 'package:myevent/src/utils/strings.dart';

part 'apiService.chopper.dart';

@ChopperApi(baseUrl: baseUrl)
abstract class ApiService extends ChopperService {
  static ApiService create([ChopperClient client]) => _$ApiService(client);

  @Post(path: '/api/login', headers: {'Accept': 'application/json'})
  Future<Response> login(@Body() Map<String, dynamic> body);

  @Post(path: '/api/register', headers: {'Accept': 'application/json'})
  Future<Response> register(@Body() Map<String, dynamic> body);

  @Post(path: '/api/register/facebook', headers: {'Accept': 'application/json'})
  Future<Response> registerFacebook(@Body() Map<String, dynamic> body);

  @Post(path: '/api/register/twitter', headers: {'Accept': 'application/json'})
  Future<Response> registerTwitter(@Body() Map<String, dynamic> body);

  @Get(path: '/api/getuserbyid', headers: {'Accept': 'application/json'})
  Future<Response> user(@Header('Authorization') String token);

  @Post(path: '/api/updateuser', headers: {'Accept': 'application/json'})
  Future<Response> updateuser(
      @Header('Authorization') String token, @Body() Map<String, dynamic> body);

  @Post(path: '/api/getuser', headers: {'Accept': 'application/json'})
  Future<Response> getuser(
      @Header('Authorization') String token, @Body() Map<String, dynamic> body);

  @Post(
      path: '/api/getuser/password/email',
      headers: {'Accept': 'application/json'})
  Future<Response> forgetPassword(
      @Header('Authorization') String token, @Body() Map<String, dynamic> body);

  @Get(path: '/api/logout', headers: {'Accept': 'application/json'})
  Future<Response> logout(@Header('Authorization') String token);
}
