import 'dart:io';

import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:flutter/material.dart';

// * Once the onboarding process is completed you will be taken to this screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AtKey ledkey = AtKey.public('led').build();
  String state = '0';
  @override
  void initState() {
    // TODO: implement initState
    getButtonVal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // * Getting the AtClientManager instance to use below
    AtClientManager atClientManager = AtClientManager.getInstance();

    return Scaffold(
      appBar: AppBar(
        title: const Text('LED Button!'),
      ),
      body: Center(
        child: Column(children: [
          const Text('Turn the LED on your Pico W on and off'),
          ElevatedButton(
              onPressed: changeValue, child: const Text('LED Light Switch')),
          // * Use the AtClientManager instance to get the AtClient
          // * Then use the AtClient to get the current @sign
          Text('Current LED val: $state')
        ]),
      ),
    );
  }

  Future<String?> getButtonVal() async {
    AtClientManager atClientManager = AtClientManager.getInstance();
    var atClient = atClientManager.atClient;
    try {
      AtValue val = await atClient.get(ledkey);
      print('ledkey: ${ledkey.toString()}');
      print('val => ${val.value}');
      setState(() {
        state = val.value;
      });
      return val.value;
    } catch (e) {
      return null;
    }
  }

  Future<void> changeValue() async {
    AtClientManager atClientManager = AtClientManager.getInstance();
    var atClient = atClientManager.atClient;
    String? currBtn = await getButtonVal();
    if (currBtn == '0') {
      await atClient.put(ledkey, '1');
      setState(() {
        state = '1';
      });
    } else {
      await atClient.put(ledkey, '0');
      setState(() {
        state = '0';
      });
    }
  }
}
