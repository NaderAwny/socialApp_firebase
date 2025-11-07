abstract class sociallayout {}

class socialintialstate extends sociallayout {}

class socialloadin extends sociallayout {}

class socialsufful extends sociallayout {}

class changebottomNavstates extends sociallayout {}

class socialError extends sociallayout {
  String message;
  socialError({required this.message});
}

class NewpostbottomNavstates extends sociallayout {}

class socialprofileimagestatesSuccful extends sociallayout {}

class socialprofileimagestatesError extends sociallayout {}

class socialcoverimagestatesSuccful extends sociallayout {}

class socialcoverimagestatesError extends sociallayout {}

class socialupdatstatesError extends sociallayout {}

class socialupdatstatesloading extends sociallayout {}

class socialcreatepoststatesError extends sociallayout {}

class socialcreatepoststatesSuccful extends sociallayout {}

class getpostloading extends sociallayout {}

class getpostsuccful extends sociallayout {}

class getpostError extends sociallayout {
  String message;
  getpostError({required this.message});
}

class sociallikehostsuccfull extends sociallayout {}

class sociallikehosterror extends sociallayout {
  String message;
  sociallikehosterror({required this.message});
}

class socialcommenthostsuccfull extends sociallayout {}

class SocialCommentsLoaded extends sociallayout {}

class SocialCommentserror extends sociallayout {
  String message;
  SocialCommentserror({required this.message});
}

class getalluerssuccful extends sociallayout {}

class getallusersError extends sociallayout {
  String message;
  getallusersError({required this.message});
}

class sendmessagestatessuccfull extends sociallayout {}

class sendmessagestatesError extends sociallayout {
  String message;
  sendmessagestatesError({required this.message});
}

class getmessagestatessuccfull extends sociallayout {}

