import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor/layout/shop_layout_screan.dart';
import 'package:stor/modules/login/login_cubit/login_state.dart';
import 'package:stor/modules/register/register_screan_module.dart';
import 'package:stor/shared/service/local/sheardp_helper.dart';
import 'package:stor/shared/widget/constante.dart';
import 'package:stor/shared/widget/defolte_widget.dart';

import 'login_cubit/login_cubit.dart';

class LoginScreanModule extends StatelessWidget {
  LoginScreanModule({Key? key}) : super(key: key);
  final TextEditingController emailControler = TextEditingController();
  final TextEditingController passwordControler = TextEditingController();
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginScassesState) {
            if (state.userModel.status!) {
              log(state.userModel.message.toString());
              log(state.userModel.data!.token!);
              SherdHelper.saveData(
                      key: "Token",
                      value: state.userModel.data!.token!.toString())
                  .then((value) {
                token = state.userModel.data!.token!;
                navigateaAndFinsh(
                  context,
                  const ShopLayoutScrean(),
                );
              });
            } else {
              log(state.userModel.message.toString());
              toastShow(
                  mass: state.userModel.message.toString(),
                  state: ToastStatus.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: keyForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "LOGIN",
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: const Color(0xFF343F56),
                            ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "welcome back...",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: const Color(0xFFE9896A),
                            ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.13,
                      ),
                      defoltTextForm(
                        context: context,
                        controler: emailControler,
                        valedat: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Email ";
                          }
                          return null;
                        },
                        lable: "Email Address",
                        pIcon: Icons.email,
                        type: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defoltTextForm(
                        context: context,
                        controler: passwordControler,
                        valedat: (value) {
                          if (value!.isEmpty) {
                            return "The Password is very Short ";
                          }
                          return null;
                        },
                        isPassword: LoginCubit.get(context).showPass,
                        lable: "Password",
                        pIcon: Icons.lock,
                        sIcon: LoginCubit.get(context).suffix,
                        sFOntap: () {
                          LoginCubit.get(context).showPassWord();
                        },
                        type: TextInputType.visiblePassword,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: state is! LoginLodingState
                            ? defoltElvationBottom(
                                onTap: () {
                                  if (keyForm.currentState!.validate()) {
                                    LoginCubit.get(context).userLoginData(
                                        email: emailControler.text,
                                        password: passwordControler.text);
                                  }
                                },
                                text: "Login")
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account ? "),
                          defoltTextBottom(
                              onTap: () {
                                navigateTo(context, RegisterScreanModule());
                              },
                              text: "Register")
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
