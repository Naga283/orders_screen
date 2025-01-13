import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancing/constants/image_constants.dart';
import 'package:freelancing/screens/orders/bloc/order_state/order_state.dart';
import 'package:freelancing/screens/orders/bloc/order_state/widget_visibity_state.dart';
import 'package:freelancing/screens/orders/bloc/radio_bloc.dart';
import 'package:freelancing/screens/orders/bloc/stepper_bloc.dart';
import 'package:freelancing/screens/orders/bloc/widget_visibililty_bloc.dart';
import 'package:freelancing/screens/orders/components/dellivary_address.dart';
import 'package:freelancing/screens/orders/components/exchange_or_return/exchange_or_return.dart';
import 'package:freelancing/screens/orders/components/invoice_widget.dart';
import 'package:freelancing/screens/orders/components/need_help_widget.dart';
import 'package:freelancing/screens/orders/components/order_components.dart';
import 'package:freelancing/screens/orders/components/order_summary.dart';
import 'package:freelancing/screens/orders/components/vertical_stepper.dart';
import 'package:freelancing/utils/colors.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<String> steps = [
    'Order Confirmed, Tue 24th 2024 | 10:26 AM',
    "Picked up by courier partner Wed, 25th Jan '25 - 7:05pm",
    'Yet to Shipped',
    'Expected by, Mon 30th Jan ‘25',
  ];
  List<String> returnReason = [
    "Damaged Product",
    "Wrong Item Delivered",
    "Item Not as Described",
    "Received Defective Product",
    "Size/Fit Issue",
    "Better Price Available Elsewhere",
    "Change of Mind",
    "Other (please specify)",
  ];

  List<String> exchangeReasons = [
    "Want to exchange for a different variant (e.g., color, size, or model)",
    "The product received is physically damaged or broken.",
    "Certain parts or accessories mentioned on the box or product description are missing.",
    "Other (please specify)",
  ];
  List<String> returnSteps = [
    "Return Applied, 11th Jan ‘25 12:43 AM",
    "Return Approved by Seller",
    "Pickup Completed",
    "Refund Completed",
  ];

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme;
    final radioButtonBloc = BlocProvider.of<RadioButtonBloc>(context);
    final widgetsVisibleBloc = context.watch<WidgetVisibilityBloc>();
    final stepperBloc = context.watch<StepperBloc>();
    final state = context.watch<RadioButtonBloc>().state;
    final stepperState = context.watch<StepperBloc>().state;
    // Determine leftText based on the isReturned value from StepperBloc
    String leftText = stepperState is StepperInitial && stepperState.isReturned
        ? "Check the product"
        : "Buy it again";

    return Scaffold(
      backgroundColor: appColors.white,
      appBar: AppBar(
        // surfaceTintColor: appColors.white,
        // backgroundColor: appColors.white,
        centerTitle: true,
        elevation: 4.0, // Add elevation here
        title: Text(
          "Track Order",
          style: textStyle.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: appColors.lightViolet,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order ID: 3354-6546-5452",
                style: textStyle.bodyMedium?.copyWith(
                  color: appColors.grey,
                  // fontWeight: FontWeight.w800,
                ),
              ),
              OrderDetails(textStyle: textStyle),
              SizedBox(height: 24),
              DottedLine(
                  dashLength: 8,
                  dashGapLength: 4,
                  dashColor: appColors.dashCol),
              // Check if the state is ShowExchangeOrReturnWidget
              widgetsVisibleBloc.state is ExchangeOrReturnWidgetState
                  ? ExchangeOrReturnWidget(
                      radioButtonBloc: radioButtonBloc,
                      reasonList: returnReason,
                      exchangeList: exchangeReasons,
                      widgetsVisibleBloc: widgetsVisibleBloc,
                      stepperBloc: stepperBloc,
                    )
                  : Column(
                      children: [
                        InvoiceWidget(
                          textStyle: textStyle,
                          stepperBloc: stepperBloc,
                          leftText: leftText,
                        ),
                        Row(
                          children: [
                            Image.asset(truckTick),
                            SizedBox(width: 9),
                            Text(
                              (state.mainSelectedValue != null)
                                  ? "Estimated Pickup : Dec 30,2024"
                                  : "Estimated Delivery : Dec 30,2024",
                              style: textStyle.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: appColors.lightOrange,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        VerticalStepper(
                          steps: state.mainSelectedValue != null
                              ? returnSteps
                              : steps,
                          radioBtnState: state,
                        ),
                        Divider(),
                        DeliveryAddress(textStyle: textStyle),
                        NeedHelpWidget(
                          textStyle: textStyle,
                          orderId: '3354-6546-5452',
                          steps: steps,
                          widgetVisibilityBloc: widgetsVisibleBloc,
                        ),
                        // Divider(),
                        OrderSummary(),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
