import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pap_report/utils/custom_toast.dart';
import 'package:pap_report/utils/generic_state/states/states.dart';

class UiStateHandler<T, B extends BlocBase<GenericState<T>>>
    extends StatelessWidget {
  final Widget Function(T data) onSuccess;
  final Widget? loadingWidget;
  final Widget? Function(Error<T> error)? errorWidget;
  final Widget? emptyWidget;

  const UiStateHandler({
    super.key,
    required this.onSuccess,
    this.loadingWidget,
    this.errorWidget,
    this.emptyWidget,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, GenericState<T>>(
      listener: (context, state) {
        if (state is Error<T>) {
          CustomToast.instance.showCustomErrorToast('Error: ${state.message}');
        }
      },
      child: BlocBuilder<B, GenericState<T>>(
        builder: (context, state) {
          if (state is Loading<T>) {
            return loadingWidget ??
                const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is Empty<T>) {
            return emptyWidget ??
                const Center(child: Text("No Data Available"));
          } else if (state is Success<T>) {
            return onSuccess(state.data);
          } else if (state is Error<T>) {
            return errorWidget?.call(state) ??
                Center(child: Text('Error: ${state.message}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
