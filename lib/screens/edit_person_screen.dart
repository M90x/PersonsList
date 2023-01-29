import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:local_assignment/get_it.dart';
import 'package:local_assignment/controller/person_bloc.dart';
import 'package:local_assignment/controller/person_events.dart';
import 'package:local_assignment/controller/person_states.dart';
import 'package:local_assignment/data/model/person_model.dart';
import 'package:local_assignment/widgets/custom_button.dart';
import 'package:local_assignment/widgets/custom_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class EditPersonScreen extends StatefulWidget {
  EditPersonScreen({Key? key, required this.person}) : super(key: key);

  final PersonModel person;
  @override
  State<EditPersonScreen> createState() => _EditPersonScreenState();
}

class _EditPersonScreenState extends State<EditPersonScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController countryController;

  late int _age;
  late String? _image;
  String? pickedImage ;
  late DateTime _dob;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.person.name);
    emailController = TextEditingController(text: widget.person.email);
    countryController = TextEditingController(text: widget.person.country);
    _age = int.parse(widget.person.age);
    _dob = DateTime.parse(widget.person.dob);
    _image = widget.person.image;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: BlocProvider<PersonBloc>.value(value: getIt<PersonBloc>(),child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //Edit the person name
              CustomInput(
                label: 'Name',
                icon: Icons.perm_contact_cal_rounded,
                textEditingController: nameController,
              ),

              //Edit the person email
              CustomInput(
                label: 'Email',
                icon: Icons.email,
                textEditingController: emailController,
              ),

              //Edit the person country
              CustomInput(
                label: 'Country',
                icon: Icons.map,
                textEditingController: countryController,
              ),
              SizedBox(height: 20.0,),

              //View the old avatar
              BlocBuilder<PersonBloc,PersonStates>(
                builder: (context, state) {
                  if(state.pickedImage!=null ){
                    return Center(child: Image.memory(state.pickedImage!,width: 80,height: 80,));
                  }else if( _image != null){
                    return Center(child: Image.memory( Uint8List.fromList(_image!.codeUnits)!,width: 80,height: 80,));

                  }else{
                    return  SizedBox();
                  }
                },
              ),

              //Button to open the gallery to choose another avatar
              InkWell(onTap: ()async{
                final ImagePicker _picker = ImagePicker();
                await _picker
                    .pickImage(source: ImageSource.gallery)
                    .then((value) async {
                  if (value != null) {
                    String  tmpImage =String.fromCharCodes(await value.readAsBytes());
                    setState(() {
                      pickedImage = tmpImage;
                    });
                    getIt<PersonBloc>().add(PickImageEvent(file: value));
                  }
                });

              },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: const Center(
                      child: Text(
                        'Pick Image',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      )),
                ),
              ),
              SizedBox(height: 20.0),

              //Button to open the calendar to edit the date of birth
              //and calculate the person age
              InkWell(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: _dob,
                    firstDate: DateTime(1950, 1),
                    lastDate: DateTime.now(),
                  ).then((value) {
                    if (value != null) {
                      String age = (DateTime.now().year - value.year).toString();
                      setState(() {
                        _age = int.parse(age);
                      });
                      print('value $value');
                    }
                  });
                },
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Icon(Icons.date_range_sharp),
                        ),
                        Text(
                          "$_age years old",
                          style:const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),

              //Edit and store new person data button
              CustomButton(
                title: 'Edit',
                onTap: () {
                  PersonModel personModel = PersonModel(
                      email: emailController.text,
                      age: _age.toString(),
                      country: countryController.text,
                      name: nameController.text,
                      image: pickedImage??_image,
                      dob: _dob.toString());
                  getIt<PersonBloc>().add(EditPersonEvent(oldPersonModel: widget.person, newPersonModel: personModel));
                  getIt<PersonBloc>().add(GetPersonsEvent());
                  Navigator.pop(context);
                },
              )
            ],
          ),
        )),
      ),
    );
  }
}
