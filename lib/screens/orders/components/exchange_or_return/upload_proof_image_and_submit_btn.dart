import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancing/constants/image_constants.dart';
import 'package:freelancing/screens/orders/bloc/files_dailog_bloc.dart';
import 'package:freelancing/screens/orders/bloc/order_event/files_event.dart';
import 'package:freelancing/screens/orders/bloc/order_state/file_dailog_state.dart';
import 'package:freelancing/screens/orders/bloc/radio_bloc.dart';
import 'package:freelancing/screens/orders/bloc/stepper_bloc.dart';
import 'package:freelancing/screens/orders/bloc/widget_visibililty_bloc.dart';
import 'package:freelancing/screens/orders/components/custom_elevated_button.dart';
import 'package:freelancing/screens/orders/components/show_upload_images_dailog.dart';
import 'package:freelancing/screens/orders/components/successfully_submit_dailog.dart';
import 'package:freelancing/utils/colors.dart';

class UploadProofImageAndSubmit extends StatelessWidget {
  const UploadProofImageAndSubmit({
    super.key,
    required this.fileDialogBloc,
    required this.fileState,
    required this.widgetsVisibleBloc,
    required this.stepperBloc,
  });

  final FileDialogBloc fileDialogBloc;
  final FileDialogState fileState;
  final WidgetVisibilityBloc widgetsVisibleBloc;
  final StepperBloc stepperBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Only show the Upload Proof button and Submit button when the main radio button is selected
        if (context.watch<RadioButtonBloc>().state.mainSelectedValue != null)
          Column(
            children: [
              // Wrap widget for displaying uploaded images
              Container(
                padding: const EdgeInsets.only(top: 14.0, bottom: 10),
                width: double.infinity, // Ensure the container takes full width
                child: Wrap(
                  alignment: WrapAlignment.start, // Align items to the start
                  spacing: 8.0,
                  runSpacing: 8.0, // Adds space between rows
                  children: fileState.uploadedFiles
                      .map((file) => Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: GestureDetector(
                              onTap: () {
                                final updatedFiles =
                                    List.of(fileState.uploadedFiles)
                                      ..remove(file);
                                fileDialogBloc.add(CloseDialogEvent());
                                fileDialogBloc.emit(
                                  FileDialogClosed(updatedFiles),
                                );
                              },
                              child: Stack(
                                clipBehavior: Clip
                                    .none, // Ensures that the icon doesn't get clipped
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        6.0), // Apply border radius to the image
                                    child: Image.file(
                                      File(file.path!),
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top:
                                        -10, // Adjust this value to move the icon slightly outside the image
                                    right:
                                        -8, // Adjust this value to move the icon slightly outside the image
                                    child: GestureDetector(
                                      onTap: () {
                                        final updatedFiles =
                                            List.of(fileState.uploadedFiles)
                                              ..remove(file);
                                        fileDialogBloc.add(CloseDialogEvent());
                                        fileDialogBloc.emit(
                                          FileDialogClosed(updatedFiles),
                                        );
                                      },
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: appColors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 5.0,
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.black,
                                          size: 10,
                                        ),
                                        padding: EdgeInsets
                                            .zero, // Remove padding to center the icon
                                        alignment: Alignment
                                            .center, // Center the icon inside the button
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              CustomElevatedBtn(
                btnName: "Upload Proof Images & videos",
                onTap: () async {
                  fileDialogBloc.add(OpenDialogEvent());
                  showFilePickerDialog(context, fileDialogBloc);
                },
                icon: Image.asset(uploadIcon),
                btnBorderColor: appColors.lightOrange,
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: appColors.lightOrange),
                padding: EdgeInsets.symmetric(vertical: 11, horizontal: 17),
              ),
              SizedBox(
                height: 23,
              ),
              CustomElevatedBtn(
                btnName: "Submit",
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 22),
                onTap: () async {
                  // Check if the button should be enabled
                  final fileState = context.read<FileDialogBloc>().state;
                  final state = context.read<RadioButtonBloc>().state;
                  final mainSelected = state.mainSelectedValue;
                  final subSelected = state.subSelectedValue;
                  final uploadedFiles = fileState.uploadedFiles;

                  // Ensure that the button only performs action if the required conditions are met
                  if (uploadedFiles.isNotEmpty && subSelected != null) {
                    // Proceed with submitting data
                    print("Main selected: $mainSelected");
                    print("Sub selected: $subSelected");
                    print(
                        "Uploaded files: ${uploadedFiles.map((file) => file.path).join(', ')}");

                    // Proceed to show success dialog
                    await successfullySubmitDailog(
                      context,
                      widgetsVisibleBloc,
                      stepperBloc,
                    );
                  } else {
                    // Optionally, you can show an error or feedback here if the conditions are not met
                    print("Button is disabled: Missing file or sub option.");
                  }
                },
                bgColor: (context
                            .read<FileDialogBloc>()
                            .state
                            .uploadedFiles
                            .isNotEmpty &&
                        context
                                .read<RadioButtonBloc>()
                                .state
                                .subSelectedValue !=
                            null)
                    ? appColors.lightViolet // Enable color when conditions met
                    : Colors.grey,
                btnBorderColor: (context
                            .read<FileDialogBloc>()
                            .state
                            .uploadedFiles
                            .isNotEmpty &&
                        context
                                .read<RadioButtonBloc>()
                                .state
                                .subSelectedValue !=
                            null)
                    ? appColors.lightViolet // Enable color when conditions met
                    : Colors.grey,
                textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: appColors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
      ],
    );
  }
}
