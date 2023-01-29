import 'dart:typed_data';
import 'package:local_assignment/get_it.dart';
import 'package:local_assignment/controller/person_events.dart';
import 'package:local_assignment/controller/person_states.dart';
import 'package:local_assignment/data/model/person_model.dart';
import 'package:local_assignment/data/shared_pref/shared_pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PersonBloc extends Bloc<PersonEvents,PersonStates>{

  PersonBloc():super(PersonStates(allPersons: null)){
    on<AddPersonEvent>(addPersonEvent);
    on<GetPersonsEvent>(getPersons);
    on<EditPersonEvent>(editPersonEvent);
    on<PickImageEvent>(pickImageEvent);
  }


  addPersonEvent(AddPersonEvent event, emit){

    PersonModel currentPerson = event.personModel;
    List<PersonModel>? persons = getIt<SharedPrefHelper>().getAllPersons();

    if(persons!=null){
      persons.add(currentPerson);
      List<PersonModel> uniqueList = persons.toSet().toList();
      getIt<SharedPrefHelper>().savePerson(uniqueList);
    }else{
      getIt<SharedPrefHelper>().savePerson([currentPerson]);
    }

  }


  getPersons(GetPersonsEvent event,Emitter emit){
    List<PersonModel> ?persons = getIt<SharedPrefHelper>().getAllPersons();
    emit(PersonStates(allPersons: persons));
  }


  editPersonEvent(EditPersonEvent event,Emitter emit){
    List<PersonModel> ? persons = getIt<SharedPrefHelper>().getAllPersons();

    int ?index= persons?.indexWhere((element) => element.runtimeType ==event.oldPersonModel.runtimeType);
    if(index!=null){
      persons?.removeAt(index);

      if(persons!=null){
        persons.add(event.newPersonModel);
        List<PersonModel> uniqueList = persons.toSet().toList();
        getIt<SharedPrefHelper>().savePerson(uniqueList);
      }else{
        getIt<SharedPrefHelper>().savePerson([event.newPersonModel]);
      }
    }
  }


  pickImageEvent(PickImageEvent event , Emitter emit)async{
    Uint8List imageUint8List =await event.file.readAsBytes();
    emit(PersonStates().copyWith(pickedImage:imageUint8List ));
  }

}