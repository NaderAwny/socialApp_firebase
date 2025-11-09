abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoading extends AuthStates {}

class AuthSuccessFullLogin extends AuthStates {
  final String? emailError;
  final String? passwordError;
  final String? nameError;
  final String? conforimError;
  final String? name;
  final String? phone;

  AuthSuccessFullLogin({
    this.emailError,
    this.passwordError,
    this.nameError,
    this.conforimError,
    this.name,
    this.phone,
  });
}

class AuthError extends AuthStates {
  final String? message;
  AuthError(this.message);
}

class AuthSuccessFullRegister extends AuthStates {
  final String? emailError;
  final String? passwordError;
  final String? nameError;
  final String? conforimError;
  final String? name;
  final String? phone;

  AuthSuccessFullRegister({
    this.emailError,
    this.passwordError,
    this.nameError,
    this.conforimError,
    this.name,
    this.phone,
  });
}

class AuthErrorRegister extends AuthStates {
  final String? message;
  AuthErrorRegister(this.message);
}



class SocialCreateUsersSuccessfulState extends AuthStates {}

class SocialCreateUsersError extends AuthStates {
  String message;

  SocialCreateUsersError(this.message);

}
class LogoutStates extends AuthStates {}
