import 'dart:typed_data';
import 'package:local_assignment/data/model/person_model.dart';


class PersonStates{
  PersonStates({ this.allPersons,this.pickedImage});

  List<PersonModel> ?allPersons;
  Uint8List ?pickedImage;

  PersonStates copyWith({
    List<PersonModel> ?allPersons,
    Uint8List ?pickedImage
  }) {
    return PersonStates(
      allPersons: allPersons ?? this.allPersons,
      pickedImage: pickedImage ?? this.pickedImage,
    );
  }

}