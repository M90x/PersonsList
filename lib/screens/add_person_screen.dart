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


class AddPersonScreen extends StatefulWidget {
  AddPersonScreen({Key? key}) : super(key: key);

  @override
  State<AddPersonScreen> createState() => _AddPersonScreenState();
}

class _AddPersonScreenState extends State<AddPersonScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  int _age = 0;
  String? image ;
  DateTime _dob = DateTime.now(); //

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

              //Enter the person name
              CustomInput(
                label: 'Name',
                icon: Icons.perm_contact_cal_rounded,
                textEditingController: nameController,
              ),

              //Enter the person email
              CustomInput(
                label: 'Email',
                icon: Icons.email,
                textEditingController: emailController,
              ),

              //Enter the person country
              CustomInput(
                label: 'Country',
                icon: Icons.map,
                textEditingController: countryController,
              ),
              SizedBox(height: 20.0,),

              //View the avatar if he chooses it from gallery
              BlocBuilder<PersonBloc,PersonStates>(
                builder: (context, state) {
                  if(state.pickedImage!=null){
                    return Center(child: Image.memory(state.pickedImage!,width: 80,height: 80,));
                  }else{
                    return  SizedBox();
                  }
                },
              ),
              SizedBox(height: 15,),

              //Button to open the gallery to choose an avatar
              InkWell(
                onTap: () async {
                  final ImagePicker _picker = ImagePicker();
                  await _picker
                      .pickImage(source: ImageSource.gallery)
                      .then((value) async {
                    if (value != null) {
                      String  tmpImage =String.fromCharCodes(await value.readAsBytes());
                      setState(() {
                        image = tmpImage;
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

              //Button to open the calendar to choose the date of birth
              //and calculate the person age
              InkWell(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950, 1),
                    lastDate: DateTime.now(),
                  ).then((value) {
                    if (value != null) {
                      String age = (DateTime.now().year - value.year).toString();
                      setState(() {
                        _age = int.parse(age);
                      });
                      setState(() {
                        _dob = value;
                      });
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
                          style: const TextStyle(
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

              //Add and store person data button
              CustomButton(
                title: 'Add Person',
                onTap: () {
                  PersonModel personModel = PersonModel(
                      email: emailController.text,
                      age: _age.toString(),
                      country: countryController.text,
                      name: nameController.text,
                      image: image,
                      dob: _dob.toString());
                  getIt<PersonBloc>()
                      .add(AddPersonEvent(personModel: personModel));
                  getIt<PersonBloc>().add(GetPersonsEvent());
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        )),
      ),
    );
  }
}
