import 'dart:convert';
import 'package:local_assignment/data/model/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPrefHelper{

  static  SharedPreferences? pref;
  SharedPrefHelper(){
    init();
  }

  static  init()async{
    pref= await SharedPreferences.getInstance();
  }

  savePerson(List<PersonModel> person){
    List<String> data = person.map((e) =>jsonEncode(e.toMap())).toList();
    pref?.setStringList('persons_test',data);
  }

  List<PersonModel> ? getAllPersons(){
    List<String>? data=  pref?.getStringList('persons_test');

    if(data!=null){
      List decData = data.map((e) => jsonDecode(e)).toList();
      List<PersonModel> personsModel= decData.map((e) => PersonModel.fromJson(e)).toList();
      return personsModel;
    }
    return null;
  }

  clear(){
    pref?.remove('persons_test');
  }

}