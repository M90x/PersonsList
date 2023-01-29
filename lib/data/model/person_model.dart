import 'package:equatable/equatable.dart';


class PersonModel extends Equatable{
  //final int id;
  final String name;
  final String email;
  final String? image;
  final String age;
  final String dob;
  final String country;
  PersonModel({required this.email,required this.age,required this.country, required this.name,required this.image,required this.dob});


  factory PersonModel.fromJson(Map<String,dynamic> json){
    return PersonModel(
      //id: json['id'],
      name: json['name'],
      email: json['email'],
      country: json['country'],
      image: json['image'],
      dob: json['dob'],
      age: json['age'],
    );
  }

  toMap(){
    return {
      'name':name,
      'country':country,
      'email':email,
      'age':age,
      'dob':dob,
      'image':image,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name,country,email,dob,image];
}