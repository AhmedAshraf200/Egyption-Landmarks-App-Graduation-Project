
abstract class ChatStates{}

class ChatInitialState extends ChatStates{}



//pick image
class ChatImagePickedSuccessState extends ChatStates{}
class ChatImagePickedErrorState extends ChatStates{}




class GetResponseSuccessState extends ChatStates{}
class AddResponseToListSuccessState extends ChatStates{}


class GetSuggestQLoadingState extends ChatStates{}
class GetSuggestQSuccessState extends ChatStates{}
class GetSuggestQErrorState extends ChatStates{}


class PostQLoadingState extends ChatStates{}
class PostQSuccessState extends ChatStates{}
class PostQErrorState extends ChatStates{}




class GetClassNameSuccessState extends ChatStates{}




class GetClassesInfoNameLoadingState extends ChatStates{}
class GetClassesInfoNameSuccessState extends ChatStates{}
class GetClassesInfoNameErrorState extends ChatStates{}








