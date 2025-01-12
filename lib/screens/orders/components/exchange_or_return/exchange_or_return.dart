import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancing/screens/orders/bloc/files_dailog_bloc.dart';
import 'package:freelancing/screens/orders/bloc/order_event/radio_btn_event.dart';
import 'package:freelancing/screens/orders/bloc/order_state/file_dailog_state.dart';
import 'package:freelancing/screens/orders/bloc/order_state/radio_state.dart';
import 'package:freelancing/screens/orders/bloc/radio_bloc.dart';
import 'package:freelancing/screens/orders/bloc/stepper_bloc.dart';
import 'package:freelancing/screens/orders/bloc/widget_visibililty_bloc.dart';
import 'package:freelancing/screens/orders/components/exchange_or_return/radio_button.dart';
import 'package:freelancing/screens/orders/components/exchange_or_return/upload_proof_image_and_submit_btn.dart';
import 'package:freelancing/utils/colors.dart';

class ExchangeOrReturnWidget extends StatelessWidget {
  const ExchangeOrReturnWidget({
    super.key,
    required this.radioButtonBloc,
    required this.reasonList,
    required this.exchangeList,
    required this.widgetsVisibleBloc,
    required this.stepperBloc,
  });

  final RadioButtonBloc radioButtonBloc;
  final List<String> reasonList;
  final List<String> exchangeList;
  final WidgetVisibilityBloc widgetsVisibleBloc;
  final StepperBloc stepperBloc;

  @override
  Widget build(BuildContext context) {
    final fileDialogBloc = context.read<FileDialogBloc>();
    return Column(
      children: [
        // Radio button selection for main options
        BlocBuilder<RadioButtonBloc, RadioButtonState>(
          builder: (context, state) {
            final mainSelectedValue = state.mainSelectedValue;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 12),
                  child: Text(
                    "Want to return product?",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: appColors.lightViolet,
                        ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioButton(
                      value: 'return',
                      groupValue: mainSelectedValue,
                      onChanged: (_) {
                        radioButtonBloc.add(SelectMainOptionEvent('return'));
                      },
                      btnName:
                          'Do you want to return the product? (Applicable within 7 days)',
                      selectedVal: state.mainSelectedValue,
                    ),
                    SizedBox(height: 15),
                    RadioButton(
                      value: 'exchange',
                      groupValue: mainSelectedValue,
                      onChanged: (_) {
                        radioButtonBloc.add(SelectMainOptionEvent('exchange'));
                      },
                      selectedVal: state.mainSelectedValue,
                      btnName:
                          'Do you want to Exchange the product? (Applicable within 7 days)',
                    ),
                  ],
                ),
                if (context.watch<RadioButtonBloc>().state.mainSelectedValue !=
                    null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      (state is DisplaySubOptionsState &&
                              state.mainSelectedValue == 'return')
                          ? "Select Reason why you want to return the product"
                          : "Select Reason why you want to Exchange the product",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: appColors.lightViolet,
                          ),
                    ),
                  ),
                // Display sub-options based on the selected main radio button
                if (state is DisplaySubOptionsState &&
                    state.mainSelectedValue == 'return')
                  ...List.generate(reasonList.length, (index) {
                    return RadioButton(
                        value: reasonList[index],
                        groupValue: state.subSelectedValue,
                        btnName: reasonList[index],
                        onChanged: (value) {
                          radioButtonBloc
                              .add(SelectSubOptionEvent(value as String));
                        },
                        selectedVal: state.subSelectedValue);
                  })
                else if (state is DisplaySubOptionsState &&
                    state.mainSelectedValue == 'exchange')
                  ...List.generate(exchangeList.length, (index) {
                    return RadioButton(
                        value: exchangeList[index],
                        groupValue: state.subSelectedValue,
                        btnName: exchangeList[index],
                        onChanged: (value) {
                          radioButtonBloc
                              .add(SelectSubOptionEvent(value as String));
                        },
                        selectedVal: state.subSelectedValue);
                  }),
              ],
            );
          },
        ),
        // Bottom section for Upload and Submit buttons
        BlocBuilder<FileDialogBloc, FileDialogState>(
          builder: (context, fileState) {
            return UploadProofImageAndSubmit(
              fileDialogBloc: fileDialogBloc,
              fileState: fileState,
              widgetsVisibleBloc: widgetsVisibleBloc,
              stepperBloc: stepperBloc,
            );
          },
        ),
      ],
    );
  }
}
