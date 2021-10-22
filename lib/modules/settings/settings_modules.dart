import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor/modules/login/login_screan_module.dart';
import 'package:stor/shared/provider/cubit.dart';
import 'package:stor/shared/provider/state.dart';
import 'package:stor/shared/service/local/sheardp_helper.dart';
import 'package:stor/shared/widget/defolte_widget.dart';

class SettingsMedules extends StatelessWidget {
  SettingsMedules({Key? key}) : super(key: key);
  final keyForm = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StorCubit, StorState>(
      listener: (context, state) {},
      builder: (context, state) {
        emailController.text = StorCubit.get(context).uModel!.data!.email!;
        nameController.text = StorCubit.get(context).uModel!.data!.name!;
        phoneController.text = StorCubit.get(context).uModel!.data!.phone!;
        return StorCubit.get(context).uModel != null
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: keyForm,
                  child: Column(
                    children: [
                      defoltTextForm(
                          context: context,
                          controler: nameController,
                          valedat: (value) {
                            if (value!.isEmpty) {
                              return "Enter your name";
                            }
                            return null;
                          },
                          lable: "User Name",
                          pIcon: Icons.person,
                          type: TextInputType.name),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defoltTextForm(
                          context: context,
                          controler: emailController,
                          valedat: (value) {
                            if (value!.isEmpty) {
                              return "Enter your Email";
                            }
                            return null;
                          },
                          lable: "Email",
                          pIcon: Icons.email,
                          type: TextInputType.emailAddress),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defoltTextForm(
                          context: context,
                          controler: phoneController,
                          valedat: (value) {
                            if (value!.isEmpty) {
                              return "Enter your phone";
                            }
                            return null;
                          },
                          lable: "Phone",
                          pIcon: Icons.phone,
                          type: TextInputType.phone),
                      const SizedBox(
                        height: 20.0,
                      ),
                      state is! UpDateLodingState
                          ? SizedBox(
                              width: double.infinity,
                              child: defoltElvationBottom(
                                  onTap: () {
                                    if (keyForm.currentState!.validate()) {
                                      StorCubit.get(context).upDateProfile(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text,
                                      );
                                    }
                                  },
                                  text: "UP Data"))
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: defoltElvationBottom(
                              onTap: () {
                                SherdHelper.removData(key: 'Token').then(
                                  (value) => navigateaAndFinsh(
                                    context,
                                    LoginScreanModule(),
                                  ),
                                );
                              },
                              text: "Log Out")),
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
