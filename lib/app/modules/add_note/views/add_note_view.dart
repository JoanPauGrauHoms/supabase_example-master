// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart'; //Proporciona widgets i eines del UI (user interface)

import 'package:get/get.dart';  //Gestio d'estats i la injeccio de dependencies Flutter
import 'package:supabase_example/app/modules/home/controllers/home_controller.dart';  //Importa controlador de home

import '../controllers/add_note_controller.dart'; //Importacio del controlador del module

class AddNoteView extends GetView<AddNoteController> {
  HomeController homeC = Get.find();  //Instancia del controlador de home

  AddNoteView({super.key}); //Obtenir el controlador d'un altre controlador
  @override
  Widget build(BuildContext context) {  //Metode que construeix i retorna la interfaç d'usuari
    return Scaffold(  //Dins es defineix la estructura (AppBar i el body com a ListView)
        appBar: AppBar(
          title: const Text('Add Note'),  //Titol de l'apartat
          centerTitle: true,  //Titol centrat
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),  //Padding que te l'apartat
          children: [
            TextField(
              controller: controller.titleC,  //Passem el controlador
              decoration: const InputDecoration(
                labelText: "Title", //Text que es mostra dins del camp title
                border: OutlineInputBorder(), //Estil de la vora
              ),
            ),
            const SizedBox(
              height: 25, //Altura del camp
            ),
            TextField(
              controller: controller.descC, //Passem el controlador
              decoration: const InputDecoration(
                labelText: "Description", //Text que es mostra dins del camp description
                border: OutlineInputBorder(), //Estil de la vora
              ),
            ),
            const SizedBox(
              height: 20, //Altura del camp
            ),
            Obx(() => ElevatedButton( //Boto per afegir la nota
                onPressed: () async { //Al polsar-lo
                  if (controller.isLoading.isFalse) { //Comprova si esta en estat de carrega
                    bool res = await controller.addNote();  //Crida per afegir una nota
                    if (res == true) {
                      await homeC.getAllNotes();  //Actualitza la llista de notes
                      Get.back(); //Tanca la pantalla a la que ens trobem
                    }
                    controller.isLoading.value = false; //Asignem el valor de carrega a fals
                  }
                },
                child: Text(
                    controller.isLoading.isFalse ? "Add note" : "Loading..."))) //Text que es mostra quan es carrega
          ],
        ));
  }
}
