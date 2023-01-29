import 'package:local_assignment/data/model/person_model.dart';
import 'package:image_picker/image_picker.dart';


abstract class PersonEvents{

}


class AddPersonEvent extends PersonEvents{
  final PersonModel personModel;
  AddPersonEvent({required this.personModel});
}


class GetPersonsEvent extends PersonEvents{

}


class EditPersonEvent extends PersonEvents{
  final PersonModel newPersonModel;
  final PersonModel oldPersonModel;
  EditPersonEvent({required this.oldPersonModel,required this.newPersonModel});
}


class PickImageEvent extends PersonEvents{
  final XFile file;
  PickImageEvent({required this.file});
}