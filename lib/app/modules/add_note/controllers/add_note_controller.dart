import 'package:flutter/cupertino.dart';  //Biblioteca proporciona widgets per a l'entorn visual iOS
import 'package:get/get.dart';  //Gestio d'estats i la injeccio de dependencies Flutter
import 'package:supabase_flutter/supabase_flutter.dart';  //Integracio amb supabase (BaaS)

class AddNoteController extends GetxController {  
  RxBool isLoading = false.obs; //Indica si s'esta carregant la aplicacio
  RxBool isHidden = true.obs; //Controlar visibilitat dels elements
  TextEditingController titleC = TextEditingController(); //Gestio de text al camp de titol de la nota
  TextEditingController descC = TextEditingController();  //Gestio de descripcio de la nota
  SupabaseClient client = Supabase.instance.client; //Usarem per interactuar amb el supabase

  Future<bool> addNote() async {
    if (titleC.text.isNotEmpty && descC.text.isNotEmpty) {  //Verifica que l'usuari ha escrit als camps
      isLoading.value = true; //Passem el valor a true perque es carrega la aplicacio
      List<dynamic> res = await client
          .from("users")
          .select("id")
          .match({"uid": client.auth.currentUser!.id});
      Map<String, dynamic> user = (res).first as Map<String, dynamic>;
      int id = user["id"]; //Obté i fa coincidir la id de l'usuar abans d'insertar a la base de dades
      await client.from("notes").insert({
        "user_id": id, //Inserta dades amb la id de l'usuari com a foreign key
        "title": titleC.text, //Passem el valor del titol de la nota
        "description": descC.text,  //Passem el valor de la descripcio de la nota
        "created_at": DateTime.now().toIso8601String(), //Passem el temps actual per saber quan s'ha creat
      });
      return true;  //Operacio exitosa
    } else {
      return false; //Operacio no exitosa
    }
  }
}

