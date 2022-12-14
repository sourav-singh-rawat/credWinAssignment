part of '../amenities.dart';

//Can add one more wrapper over it, if not want to expose provider like we did for theme

final squareAmenityImplStateProvider = StateNotifierProvider<_SquareAmenityImplStateController, _SquareState>(
  (ref) {
    final stateController = _SquareAmenityImplStateController();

    stateController.initState();

    return stateController;
  },
);

class _SquareState {
  final Color color;
  final double size;
  _SquareState({
    required this.color,
    required this.size,
  });

  _SquareState.initState()
      : this(
          color: CWAppX.globalProviderScope.read(CWAppX.theme.current).colors.secoundary,
          size: 100,
        );

  _SquareState copyWith({
    Color? color,
    double? size,
  }) {
    return _SquareState(
      color: color ?? this.color,
      size: size ?? this.size,
    );
  }
}

class _SquareAmenityImplStateController extends StateNotifier<_SquareState> implements FigureAmenity {
  _SquareAmenityImplStateController() : super(_SquareState.initState());

  void initState() {
    CWAppX.globalProviderScope.listen<CWThemeState>(CWAppX.theme.current, (previous, next) {
      onColorChanged(next.colors.secoundary);
    });
  }

  @override
  Color get color => state.color;

  @override
  void onColorChanged(Color color) {
    state = state.copyWith(
      color: color,
    );
  }

  @override
  Size get size => Size(state.size, state.size);

  @override
  void onSizeChanged(Size size) {
    state = state.copyWith(
      size: size.width,
    );
  }
}
