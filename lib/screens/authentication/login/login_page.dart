import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joblisting/bloc/auth_bloc/auth_bloc.dart';
import 'package:joblisting/components/buttons/primary_button.dart';
import 'package:joblisting/components/form/field_configs.dart';
import 'package:joblisting/components/form/universal_form_field.dart';
import 'package:joblisting/configs/app_assets.dart';
import 'package:joblisting/configs/app_colors.dart';
import 'package:joblisting/dialogs/notifier.dart';
import 'package:joblisting/extentions/list_extension.dart';
import 'package:joblisting/router/routes_name.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../../components/devider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static Widget build() {
    return const LoginPage();
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) {
        return (current is AuthAuthenticated || current is AuthError);
      },
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          GoRouter.of(context).pushNamed(RoutesName.home);
        } else if (state is AuthError) {
          Notifier(context).showSnackBar(message: state.message);
        }
      },
      child: Scaffold(
          appBar: AppBar(),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Welcome Back! Glad To\n See you Again!",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    UniversalFormField(
                            fieldType: UFFType.text,
                            label: "Email",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email';
                              } else if (!RegExp(
                                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                  .hasMatch(value)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                            controller: emailController,
                            onChanged: (value) {})
                        .build(),
                    UniversalFormField(
                            fieldType: UFFType.text,
                            label: "Password",
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Password";
                              } else if (value.length < 6) {
                                return "Password length Must be grater then 6";
                              }
                            },
                            onChanged: (value) {})
                        .build(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            GoRouter.of(context).pushNamed(RoutesName.signUp);
                          },
                          child: const Text(
                            "Create Account",
                            style: TextStyle(color: AppColors.black),
                          ),
                        ),
                        const InkWell(
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: AppColors.black),
                          ),
                        ),
                      ],
                    ),
                    PrimaryButton(
                        size: Size(MediaQuery.of(context).size.width, 40),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  AuthLoggedIn(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                          }
                        },
                        text: "Login"),
                    Row(
                      children: [
                        const Expanded(child: DividerComponent()),
                        const Text(
                          "OR",
                          style: TextStyle(color: AppColors.darkGray),
                        ),
                        const Expanded(child: DividerComponent()),
                      ].separator(2),
                    ),
                    _buildSignInButton(
                      Buttons.microsoft,
                      "Login with Microsoft",
                      onPressed: () {
                        Notifier(context).showSnackBar(
                            message: "Please Use Microsoft Login");
                      },
                    ),
                    _buildSignInButton(
                      Buttons.facebook,
                      "Login with Facebook",
                      onPressed: () {
                        Notifier(context).showSnackBar(
                            message: "Please Use Microsoft Login");
                      },
                    ),
                    _buildSignInButton(
                      Buttons.appleDark,
                      "Login with Apple",
                      onPressed: () {
                        Notifier(context).showSnackBar(
                            message: "Please Use Microsoft Login");
                      },
                    ),
                  ].separator(16),
                ),
              ),
            ),
          )),
    );
  }

  Widget _buildSignInButton(Buttons button, String text,
      {required Function onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: SignInButton(
        button,
        text: text,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12.0),
      ),
    );
  }
}
