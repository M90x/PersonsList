import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:local_assignment/data/model/person_model.dart';
import 'package:local_assignment/screens/edit_person_screen.dart';


class SinglePersonCard extends StatelessWidget {
  const SinglePersonCard({Key? key, required this.person}) : super(key: key);

  final PersonModel person;
  @override
  Widget build(BuildContext context) {


    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditPersonScreen(person: person),
            ));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 0),
                    spreadRadius: 2)
              ],
              borderRadius: BorderRadius.circular(10.0)),
          width: double.infinity,
          height: 85,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50),
                  ),

                  child:person.image !=null? Image.memory(
                    Uint8List.fromList(person.image!.codeUnits),
                    fit: BoxFit.cover,
                  ):SizedBox(),
                ),
                SizedBox(width: 10.0,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      person.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      person.email,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      person.country,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      '${person.age} Y',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
