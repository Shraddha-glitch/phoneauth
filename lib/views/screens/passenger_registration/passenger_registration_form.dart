import 'dart:io';

import 'package:autohiringapp/bloc/passanger_registration/passenger_registration_bloc.dart';
import 'package:autohiringapp/constants/colors.dart';
import 'package:autohiringapp/repositories/passenger_registration_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPassenger extends StatefulWidget {
  const RegisterPassenger({Key? key}) : super(key: key);

  @override
  State<RegisterPassenger> createState() => _RegisterPassengerState();
}

class _RegisterPassengerState extends State<RegisterPassenger> {
  @override
  Widget build(BuildContext maincontext) {
    return RepositoryProvider(
      create: (context) => PassengerRegistrationRepository(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Basic Info'),
        ),
        body: Padding(
          padding: defaultPadding,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => PassengerRegistrationBloc(
                  passengerRegistrationRepository:
                      RepositoryProvider.of<PassengerRegistrationRepository>(
                          context),
                ),
              ),
            ],
            child: const PassengerRegistrationForm(),
          ),
        ),
      ),
    );
  }
}

class PassengerRegistrationForm extends StatefulWidget {
  const PassengerRegistrationForm({Key? key}) : super(key: key);

  @override
  State<PassengerRegistrationForm> createState() =>
      _PassengerRegistrationFormState();
}

class _PassengerRegistrationFormState extends State<PassengerRegistrationForm> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  File? image;
  final _picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final passengerRegistrationBloc = context.read<PassengerRegistrationBloc>();

    return ModalProgressHUD(
      inAsyncCall: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 160,
              padding: const EdgeInsets.all(4.0),
              child: Card(
                shadowColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 8),
                      const Text(
                        'First Name',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        controller: firstName,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your first name',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 160,
              padding: const EdgeInsets.all(4.0),
              child: Card(
                shadowColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 8),
                      const Text(
                        'Second Name',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        controller: lastName,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your second name',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.all(4.0),
              child: Card(
                shadowColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 8),
                      const Text(
                        'Upload your image here',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: getImage,
                          child: image != null
                              ? Image.file(
                                  File(image!.path),
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  height: 100,
                                  width: 100,
                                  color: primaryColor,
                                  child: const Icon(
                                    Icons.add,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            BlocConsumer<PassengerRegistrationBloc, PassengerRegistrationState>(
              builder: (_, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: state == PassengerRegistrationProcess()
                        ? primaryColor
                        : null,
                  ),
                  onPressed: state == PassengerRegistrationProcess()
                      ? null
                      : () {
                          passengerRegistrationBloc
                              .add(PassengerRegistrationButtonNavigateEvent(
                                  // firstName: firstName.text,
                                  // lastName: lastName.text,
                                  // image: image
                                  ));
                        },
                  child: state == PassengerRegistrationProcess()
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: primaryColor),
                        )
                      : const Text('Register'),
                );
              },
              listener: (_, state) {
                if (state is PassengerRegistrationSuccess) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Registration Scuccess."),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else if (state is PassengerRegistrationFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Error: Registration Failed. "),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
