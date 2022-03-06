import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:to_do_app/utilites/Constants/app_colors.dart';
import 'package:to_do_app/utilites/size_config.dart';
import 'package:to_do_app/utilites/validations.dart';
import 'package:validators/validators.dart' as validator;

enum DefaultFormFieldType {
  EMAIL,
  PASSWORD,
  NUMBER,
  TEXT,
  PHONE,
  MULTI_TEXT,
  USER_NAME,
  USER_NAME_OR_EMAIL,
  FIRST_NAME,
  LAST_NAME,
  SEARCH,
}


class DefaultFormField extends StatelessWidget {
  final TextEditingController? controller;
  final DefaultFormFieldType type;
  final String? label;
  final BehaviorSubject subject;
  final FocusNode focusNode;

  const DefaultFormField({Key? key,
    required this.controller,
    required this.type,
    required this.label,
    required this.subject,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(left: SizeConfig.padding , right: SizeConfig.padding  , top: SizeConfig.padding /2 , bottom: SizeConfig.padding /2),
      child: StreamBuilder(
        stream: subject.stream,
        builder: (context, snapshot) {
          return TextFormField(
            style: TextStyle(
              color: AppColors.blackColor,
              fontWeight: FontWeight.normal,
              fontSize: SizeConfig.textFontSize,
            ),
            controller: controller,
            keyboardType:  type == DefaultFormFieldType.MULTI_TEXT
                ? TextInputType.multiline
                : type == DefaultFormFieldType.PHONE ||
                type == DefaultFormFieldType.NUMBER
                ? TextInputType.phone
                : type == DefaultFormFieldType.EMAIL
                ? TextInputType.emailAddress
                : TextInputType.text,
            focusNode: focusNode,
            autofocus: true,
            onChanged: (String input) {
              subject.sink.add(input);
            },
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.titleFontSize,
              ),
              border: const OutlineInputBorder(),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value){
              if (type == DefaultFormFieldType.EMAIL &&
                  (validator.isNull(value) ||
                      !validator.isEmail(value!))) {
                return 'email not true';
              }
              else if (type ==
                  DefaultFormFieldType.USER_NAME_OR_EMAIL &&
                  (validator.isNull(value) ||
                      !validator.isLength(value!, 8, 50))) {
                return  'email or username not true';
              }
              else if (type ==
                  DefaultFormFieldType.PASSWORD &&
                  !Validations.validatePassword(value!)) {
                return 'password must have characters and numbers';
              }
              else if (type == DefaultFormFieldType.PHONE &&
                  ( !Validations.isMobileNumberNotValid(value!) || !validator.isLength(value, 8, 11))) {
                return "phone not valid";
              }
              return null;
            },
          );
        }
      ),
    );
  }
}
