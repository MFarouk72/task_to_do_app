import 'package:flutter/material.dart';
import 'package:to_do_app/utilites/Constants/app_colors.dart';
import 'package:to_do_app/utilites/size_config.dart';

class DefaultButton extends StatelessWidget {
  final double? width ;
  final Color? backgroundColor;
  final bool? isUpperCase;
  final double? radius;
  final Function? function;
  final String? text;

  const DefaultButton({Key? key,
    required this.text,
    required this.function,
    this.width = double.infinity,
    this.backgroundColor,
    this.isUpperCase = true,
    this.radius = 7.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(left: SizeConfig.padding , right: SizeConfig.padding  , top: SizeConfig.padding /2 , bottom: SizeConfig.padding /2),
      child: Container(
        width: width,
        height: SizeConfig.safeBlockVertical * 8,
        child: MaterialButton(
          onPressed: () {
            function!();
          },
          child: Text(
            isUpperCase == true ? text!.toUpperCase() : text!,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            radius!,
          ),
          color: backgroundColor ?? AppColors.blueColor,
        ),
      ),
    );
  }
}
