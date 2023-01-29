import 'package:flutter/material.dart';
import 'package:local_assignment/get_it.dart';
import 'package:local_assignment/controller/person_bloc.dart';
import 'package:local_assignment/controller/person_events.dart';
import 'package:local_assignment/controller/person_states.dart';
import 'package:local_assignment/screens/add_person_screen.dart';
import 'package:local_assignment/widgets/single_person_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ListPersons extends StatefulWidget {
  const ListPersons({Key? key}) : super(key: key);

  @override
  State<ListPersons> createState() => _ListPersonsState();
}

class _ListPersonsState extends State<ListPersons> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      ////////////////////////////////////////////////////////
      /////////////// Add a new person button ///////////////
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // getIt<SharedPrefHelper>().clear();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  AddPersonScreen(),
              ));
        },
      ),

      appBar: AppBar(
        title: const Text(
          'Persons',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),

      body: BlocProvider<PersonBloc>.value(
        value: getIt<PersonBloc>()..add(GetPersonsEvent()),
        child: BlocBuilder<PersonBloc,PersonStates>(
          builder: (context, state) {

            ////////////////////////////////////////////////////////
            /////////////// View the list of persons ///////////////
            if(state.allPersons!=null){
              return  Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.allPersons!.length,
                        itemBuilder: (context, index) =>  SinglePersonCard(person : state.allPersons![index]),
                      ),
                    )
                  ],
                ),
              );
            }else{
              return const Center(child: Text('No Persons Found'),);
            }
          },
        ),
      ),
    );
  }
}
