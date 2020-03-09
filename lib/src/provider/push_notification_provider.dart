
import 'package:firebase_messaging/firebase_messaging.dart';

import 'dart:async';
import 'dart:io';


class PushNotificationProvider{

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajeStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajeStreamController.stream;

  initNotifications() async{
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((token){
      print('=============FCM Token============');
      print(token);
      //eUkvlfDWeLk:APA91bEAvOjHgHTLbi09vJtzOc_VuET-rulDmOyhxraTJsybWEa7GQR3-mDiKGokPWuyiSrbf42NudK6X4-JMs6JavlssgGoBAbYjRTquw-gHGFBpUKU_rqSsYBkky6LoX0mHOit5hNH

    });

    _firebaseMessaging.configure(
      onMessage: (info) async{
        print('=============FCM onMessage============');
        print(info);
        String argumento = 'no-data';
        if(Platform.isAndroid){
          argumento = info['data']['Comida']?? 'no-data';
        }else{
          argumento = info['Comida'] ?? 'no-data-ios';
        }
        _mensajeStreamController.sink.add(argumento);

      },
      onLaunch: (info) async{
        print('=============FCM onLaunch============');
        print(info);
        String argumento = 'no-data';
        if(Platform.isAndroid){
          argumento = info['data']['Comida']?? 'no-data';
        }else{
          argumento = info['Comida'] ?? 'no-data-ios';
        }
        _mensajeStreamController.sink.add(argumento);
        
      },
      onResume: (info) async{
        print('=============FCM onResume============');
        print(info);
        String argumento = 'no-data';
        if(Platform.isAndroid){
          argumento = info['data']['Comida']?? 'no-data';
        }else{
          argumento = info['Comida'] ?? 'no-data-ios';
        }
        _mensajeStreamController.sink.add(argumento);
      }
    );

    dispose(){
      _mensajeStreamController?.close();
    }

  }

}