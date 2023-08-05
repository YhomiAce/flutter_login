// ignore_for_file: prefer_const_constructors

import 'package:flut_auth/api/api_service.dart';
import 'package:flut_auth/model/login_model.dart';
import 'package:flut_auth/widgets/spinner.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showPassword = true;
  bool isLoading = false;
  LoginRequestModel? requestModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestModel = LoginRequestModel();
  }

  void showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text(
            message,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        // content: Center(
        //   child: Text(
        //     message,
        //     style: Theme.of(context).textTheme.displayMedium,
        //   ),
        // ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void onSubmit() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      setState(() {
        isLoading = true;
      });
      form.save();
      print('here');
      print(requestModel!.toJson());
      ApiService().login(requestModel!).then((value) {
        setState(() {
          isLoading = false;
        });
        showMessage('Login Successful');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isLoading,
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      // appBar: AppBar(
      //   title: Text('Login Screen'),
      // ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 10),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Login',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (newValue) =>
                                requestModel!.email = newValue,
                            validator: (value) => !value!.contains('@')
                                ? 'Please use a valid email'
                                : null,
                            decoration: InputDecoration(
                              hintText: 'Email Address',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.2),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: showPassword,
                            onSaved: (newValue) =>
                                requestModel!.password = newValue,
                            validator: (value) => value!.length < 5
                                ? 'Password should be more than 5 characters'
                                : null,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.2),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    showPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.4),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 40,
                            ),
                            child: TextButton(
                              onPressed: () => onSubmit(),
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  shape: StadiumBorder()),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
