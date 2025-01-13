import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancing/constants/image_constants.dart';
import 'package:freelancing/screens/orders/bloc/files_dailog_bloc.dart';
import 'package:freelancing/screens/orders/bloc/order_event/files_event.dart';
import 'package:freelancing/screens/orders/bloc/order_state/file_dailog_state.dart';
import 'package:freelancing/screens/orders/components/custom_elevated_button.dart';
import 'package:freelancing/utils/colors.dart';

void showFilePickerDialog(BuildContext context, FileDialogBloc fileDialogBloc) {
  showDialog(
    context: context,
    builder: (context) {
      return BlocProvider.value(
        value: fileDialogBloc,
        child: BlocBuilder<FileDialogBloc, FileDialogState>(
          builder: (context, state) {
            return AlertDialog(
              backgroundColor: appColors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: appColors.lightViolet,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Upload Photos & Videos",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        fileDialogBloc.add(SelectFilesEvent());
                      },
                      child: DottedBorder(
                        color: appColors.borderCol,
                        radius: Radius.circular(8),
                        // gap: 3,
                        borderType: BorderType.RRect,
                        strokeWidth: 1,
                        dashPattern: [3, 4],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 8),
                          child: (state.selectedFiles.isEmpty &&
                                  state.uploadedFiles.isEmpty)
                              ? Column(
                                  children: [
                                    Image.asset(uploadImage),
                                    RichText(
                                      text: TextSpan(
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: appColors.dropTextCol,
                                                fontSize: 10  ,
                                              ),
                                          text:
                                              "Drop your image & video here, or ",
                                          children: [
                                            TextSpan(
                                              text: "browse",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: appColors.darkBlue,
                                                    fontSize: 10,
                                                  ),
                                            )
                                          ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text(
                                        "Supports: PNG, JPG & MP4",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                fontSize: 10,
                                                color: appColors.lightViolet),
                                      ),
                                    )
                                  ],
                                )
                              : SizedBox(
                                  height: 120,
                                  width: 300,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.selectedFiles.isNotEmpty
                                          ? state.selectedFiles.length
                                          : state.uploadedFiles.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final fileVal =
                                            state.selectedFiles.isNotEmpty
                                                ? state.selectedFiles
                                                : state.uploadedFiles;
                                        return Padding(
                                          padding: EdgeInsets.only(right: 12),
                                          child: Image.file(
                                            File(fileVal[index].path!),
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      }),
                                ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                CustomElevatedBtn(
                  btnName: "Upload",
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 22),
                  textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600, color: appColors.white),
                  btnBorderColor:
                      (state.uploadedFiles.isNotEmpty || state.isUploadEnabled)
                          ? appColors.lightOrange
                          : appColors.grey,
                  bgColor:
                      (state.uploadedFiles.isNotEmpty || state.isUploadEnabled)
                          ? appColors.lightOrange
                          : appColors.grey,
                  onTap:
                      (state.uploadedFiles.isNotEmpty || state.isUploadEnabled)
                          ? () {
                              fileDialogBloc.add(UploadFilesEvent());
                              Navigator.pop(context);
                            }
                          : null,
                )
              ],
            );
          },
        ),
      );
    },
  );
}
