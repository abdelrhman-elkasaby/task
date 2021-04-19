import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_isaak/screens/print.dart';
import 'package:task_isaak/screens/webView.dart';
class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}
class _SettingsScreenState extends State<SettingsScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController webUrlController = TextEditingController();
  String webUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.withOpacity(0.1)),
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    controller: webUrlController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        hintText: 'Please Enter Web Url',
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please enter url';
                      } else if (!val.startsWith('https://www.') ||
                          !val.endsWith('.com')) {
                        return 'Please enter a Valid url';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  if (!formKey.currentState.validate()) {
                    return;
                  }
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          WebViewScreen(webUrlController.text)));
                },
                child: Text(
                  'Go To Web Url',
                  style: TextStyle(color: Colors.teal),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
              const SizedBox(height: 10,),
              InkWell(
                onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Print())),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.print),
                    Text('Search for printer Via Bluetooth And Wifi')
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
