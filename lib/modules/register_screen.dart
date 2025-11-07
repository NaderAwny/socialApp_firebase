import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/auth_cubit/authcubit.dart';
import 'package:shopapp/auth_cubit/authstates.dart';
import 'package:shopapp/layout/cubit_layout/social_screen.dart';
import 'package:shopapp/modules/login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool obsure = true;
  bool obsure1 = true;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final TextEditingController _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

leading: IconButton(onPressed: (){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>socialloginscreen()));


  
}, icon: Icon(Icons.arrow_back)),

      ),
      body: BlocConsumer<authcubit, authstates>(
        listener: (context, state) {
          if (state is socialcreateuserssuccfulstate) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Register Successful ✅"),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) =>socialloginscreen()),
            );
          }
          if (state is autherrorregister) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Register failed'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      " Register now communicate with frindes",

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Enter your name" : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Enter your email" : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      
                      controller: _passwordController,
                      
                      decoration: InputDecoration(
                        
                        labelText: "Password",
                        border: OutlineInputBorder(
                          
                          borderRadius: BorderRadius.circular(15),
                          
                        ),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obsure = !obsure;
                            });
                          },
                          icon: Icon(
                            obsure
                                ? Icons.visibility_off
                                : Icons.remove_red_eye,
                          ),
                        ),
                      ),
                      obscureText:obsure,
                      validator: (value) => value!.length < 6
                          ? "Password must be 6+ chars"
                          : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: " ConforumPassword",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obsure1 = !obsure1;
                            });
                          },
                          icon: Icon(
                            obsure1
                                ? Icons.visibility_off
                                : Icons.remove_red_eye,
                          ),
                        ),
                      ),
                      obscureText: obsure1,
                      validator: (value) => value != _passwordController.text
                          ? "Passwords do not match"
                          : null,
                    ),

                    SizedBox(height: 10),
                    TextFormField(
                      controller: _phone,
                      decoration: InputDecoration(
                        labelText: "phone",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Enter your phone" : null,
                    ),

                    SizedBox(height: 30),
                    state is authloading
                        ? CircularProgressIndicator()
                        : SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrange,
                                foregroundColor: Colors.black,
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  /// استدعاء cubit login
                                  authcubit
                                      .get(context)
                                      .registerUser(
                                        _nameController.text.trim(),
                                        _emailController.text.trim(),
                                        _passwordController.text.trim(),
                                        _phone.text.trim(),
                                      );
                                }
                              },
                              child: state is authloading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Register",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
