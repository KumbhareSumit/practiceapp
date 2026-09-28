import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ==========================================
// 1. THE ARCHITECTURAL STATES (Sealed Class)
// ==========================================
sealed class CounterState {}

class CounterInitial extends CounterState {}

class CounterLoading extends CounterState {}

class CounterSuccess extends CounterState {
  final int value;
  CounterSuccess(this.value);
}

class CounterError extends CounterState {
  final String errorMessage;
  CounterError(this.errorMessage);
}

// ==========================================
// 2. THE CUBIT BUSINESS LOGIC LAYER (Brain)
// ==========================================
class ControlCenterCubit extends Cubit<CounterState> {
  int _count = 0;

  // Initialize the class by sending the starting Initial state to the super constructor
  ControlCenterCubit() : super(CounterInitial());

  void incrementCounter() async {
    // Phase A: Emit a temporary loading state
    emit(CounterLoading());

    // Simulate a tiny 400ms network layout pause
    await Future.delayed(const Duration(milliseconds: 400));

    if (_count >= 5) {
      // Artificial error boundary limit for demonstration purposes
      emit(CounterError('Safety Warning: Count cannot exceed 5 blocks!'));
    } else {
      _count++;
      emit(CounterSuccess(_count));
    }
  }

  void resetCounter() {
    _count = 0;
    emit(CounterInitial());
  }
}

// ==========================================
// 3. THE UI USER INTERFACE PRESENTATION SCREEN
// ==========================================
class CubitStateScreen extends StatelessWidget {
  const CubitStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider initializes the Cubit object and injects it safely into the sub-tree
    return BlocProvider(
      create: (BuildContext context) => ControlCenterCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cubit State Management Lab'),
          backgroundColor: Colors.red,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- ARCHITECTURAL BLOCK A: THE BLOCBUILDER (UI Rendering) ---
              Expanded(
                child: Center(
                  child: BlocBuilder<ControlCenterCubit, CounterState>(
                    builder: (context, state) {
                      // Modern Dart 3.x Exhaustive Pattern Switch Expression
                      return switch (state) {
                        CounterInitial() => const Text(
                            'Click below to wake up the Cubit engine.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        CounterLoading() => const CircularProgressIndicator(color: Colors.red),
                        CounterSuccess(:final value) => Text(
                            '$value',
                            style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                        CounterError(:final errorMessage) => Text(
                            errorMessage,
                            style: const TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                      };
                    },
                  ),
                ),
              ),

              // --- ARCHITECTURAL BLOCK B: THE BLOCLISTENER (One-off Actions) ---
              // We place BlocListener here just to observe when error state structures are thrown
              BlocListener<ControlCenterCubit, CounterState>(
                listener: (context, state) {
                  if (state is CounterError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
                    );
                  }
                },
                child: const SizedBox.shrink(), // Invisible utility bridge placeholder
              ),

              // --- INTERACTION CONTROLS ---
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[200]),
                      onPressed: () => context.read<ControlCenterCubit>().resetCounter(),
                      icon: const Icon(Icons.refresh, color: Colors.black87),
                      label: const Text('Reset', style: TextStyle(color: Colors.black87)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () => context.read<ControlCenterCubit>().incrementCounter(),
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text('Increment', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
