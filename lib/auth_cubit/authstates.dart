abstract class authstates {}

class authintialsate extends authstates {}

class authloading extends authstates {}

class authsucessffullogin extends authstates {
  final String? emailError;
  final String? passwordError;
  final String? nameError;
  final String? conforimError;
  final String? name;
  final String? phone;

  authsucessffullogin({
    this.emailError,
    this.passwordError,
    this.nameError,
    this.conforimError,
    this.name,
    this.phone,
  });
}

class autherror extends authstates {
  final String? message;
  autherror(this.message);
}

class authsucessffulregsiter extends authstates {
  final String? emailError;
  final String? passwordError;
  final String? nameError;
  final String? conforimError;
  final String? name;
  final String? phone;

  authsucessffulregsiter({
    this.emailError,
    this.passwordError,
    this.nameError,
    this.conforimError,
    this.name,
    this.phone,
  });
}

class autherrorregister extends authstates {
  final String? message;
  autherrorregister(this.message);
}



class socialcreateuserssuccfulstate extends authstates {}

class socialcreateuserserror extends authstates {
  String message;

  socialcreateuserserror(this.message);

}
class logoutstates extends authstates {}
