
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_2_list/popups/notion.dart';
import 'package:flutter_application_2_list/popups/tarefas.dart';
import 'package:flutter_application_2_list/componentes/theme.dart';
import 'package:image_picker/image_picker.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
 final imagePicker = ImagePicker();
 File? imageFile;

 pick(ImageSource source) async{
   final pickedFile = await imagePicker.pickImage(source: source);

   if (pickedFile != null) {
     setState(() {
       imageFile = File(pickedFile.path);
     });
   }
 }

   @override
   void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: TestTheme.primaryColor,
        centerTitle: true,
        title: const Text('Notion2'),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: CircleAvatar(
                      backgroundColor: TestTheme.onPrimaryColor,
                      radius: 50,
                      child: CircleAvatar(
                        backgroundColor: TestTheme.onSecondaryColor,
                        radius: 45,
                        backgroundImage: imageFile != null 
                        ? FileImage(imageFile!) as ImageProvider
                        : const AssetImage('assets/imagens/perfil.jpg'),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children:  [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton.large(
                      onPressed: () {
                        showDialog(
                        context: context,
                        builder: (context) => const popuptarefas(),
                        );
                      },
                      backgroundColor: TestTheme.onPrimaryColor,
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      child: const Icon(Icons.task_alt),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FloatingActionButton.large(
                        onPressed: () {
                          showDialog(
                          context: context,
                          builder: (context) => const Notion(),
                          );
                        },
                        backgroundColor: TestTheme.onPrimaryColor,
                        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                        child: const Icon(Icons.calendar_month),
                      ),  
                    ),
                  ],
                ),
              ],),
              Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Text('Imagem de perfil')
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            pick(ImageSource.camera);
                          },
                          child: const Icon(Icons.camera_alt),
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            pick(ImageSource.gallery);
                          },
                          child: const Icon(Icons.photo),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
