abstract class SocialLayout {}

class SocialInitialState extends SocialLayout {}

class SocialLoading extends SocialLayout {}

class SocialSuccessful extends SocialLayout {}

class ChangeBottomNavStates extends SocialLayout {}

class SocialError extends SocialLayout {
  String message;
  SocialError({required this.message});
}

class NewPostBottomNavStates extends SocialLayout {}

class SocialProfileImageStatesSuccessful extends SocialLayout {}

class SocialProfileImageStatesError extends SocialLayout {}

class SocialCoverImageStatesSuccessful extends SocialLayout {}

class SocialCoverImageStatesError extends SocialLayout {}

class SocialUpdateStatesError extends SocialLayout {}

class SocialUpdateStatesLoading extends SocialLayout {}

class SocialCreatePostStatesError extends SocialLayout {}

class SocialCreatePostStatesSuccessful extends SocialLayout {}

class GetPostLoading extends SocialLayout {}

class GetPostSuccessful extends SocialLayout {}

class GetPostError extends SocialLayout {
  String message;
  GetPostError({required this.message});
}

class SocialLikeHostSuccessful extends SocialLayout {}

class SocialLikeHostError extends SocialLayout {
  String message;
  SocialLikeHostError({required this.message});
}

class SocialCommentHostSuccessful extends SocialLayout {}

class SocialCommentsLoaded extends SocialLayout {}

class SocialCommentsError extends SocialLayout {
  String message;
  SocialCommentsError({required this.message});
}

class GetAllUsersSuccessful extends SocialLayout {}

class GetAllUsersError extends SocialLayout {
  String message;
  GetAllUsersError({required this.message});
}

class SendMessageStatesSuccessful extends SocialLayout {}

class SendMessageStatesError extends SocialLayout {
  String message;
  SendMessageStatesError({required this.message});
}

class GetMessageStatesSuccessful extends SocialLayout {}

