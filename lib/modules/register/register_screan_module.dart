import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor/layout/shop_layout_screan.dart';
import 'package:stor/modules/register/register_cubit/reg_cubit.dart';
import 'package:stor/modules/register/register_cubit/register_state.dart';
import 'package:stor/shared/service/local/sheardp_helper.dart';
import 'package:stor/shared/widget/constante.dart';
import 'package:stor/shared/widget/defolte_widget.dart';

class RegisterScreanModule extends StatelessWidget {
  RegisterScreanModule({Key? key}) : super(key: key);
  final TextEditingController nameControler = TextEditingController();

  final TextEditingController emailControler = TextEditingController();
  final TextEditingController passwordControler = TextEditingController();
  final TextEditingController phoneControler = TextEditingController();

  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterScassesState) {
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
                          "REGISTER",
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: const Color(0xFF343F56),
                                  ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.13,
                        ),
                        defoltTextForm(
                          context: context,
                          controler: nameControler,
                          valedat: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter User Name ";
                            }
                            return null;
                          },
                          lable: "User Name",
                          pIcon: Icons.person,
                          type: TextInputType.name,
                        ),
                        const SizedBox(
                          height: 15.0,
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
                          isPassword: RegisterCubit.get(context).showPass,
                          lable: "Password",
                          pIcon: Icons.lock,
                          sIcon: RegisterCubit.get(context).suffix,
                          sFOntap: () {
                            RegisterCubit.get(context).showPassWord();
                          },
                          type: TextInputType.visiblePassword,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defoltTextForm(
                          context: context,
                          controler: phoneControler,
                          valedat: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Phone ";
                            }
                            return null;
                          },
                          lable: "Phone",
                          pIcon: Icons.phone,
                          type: TextInputType.phone,
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: state is! RegisterLodingState
                              ? defoltElvationBottom(
                                  onTap: () {
                                    if (keyForm.currentState!.validate()) {
                                      RegisterCubit.get(context)
                                          .userRegisterData(
                                        name: nameControler.text,
                                        email: emailControler.text,
                                        password: passwordControler.text,
                                        phone: phoneControler.text,
                                      );
                                    }
                                  },
                                  text: "Register")
                              : const Center(
                                  child: CircularProgressIndicator(),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
