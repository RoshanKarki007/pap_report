import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pap_report/feature/outlet/bloc/outlet_bloc.dart';
import 'package:pap_report/feature/outlet/bloc/outlet_event.dart';
import 'package:pap_report/feature/outlet/view/outlet_screen.dart';
import 'package:pap_report/feature/transaction/bloc/events.dart';
import 'package:pap_report/feature/transaction/bloc/transaction_bloc.dart';
import 'package:pap_report/feature/transaction/view/transaction_screen.dart';
import 'package:pap_report/widgets/custom_gradient_appbar.dart';
import 'package:pap_report/widgets/custom_scaffold.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(GetTransactions());
    context.read<OutletBloc>().add(GetOutlets());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      canDoubleBackPop: true,
      hasStatusBarHeight: false,
      appBar: GradientAppBar('CityTech Reports'),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<TransactionBloc>().add(GetTransactions());
          context.read<OutletBloc>().add(GetOutlets());
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(right: 22.w, left: 22.w, bottom: 50.h),
          child: Column(
            spacing: 12.h,
            children: [
              TransactionScreen(),
              OutletScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
