// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // 1. the architectural states sealed class

// sealed class CounterState {
//     class CounterInitial extends CounterState{}
//     class CounterLoading extends CounterState{}

//     class CounterSuccess extends CounterState{
//         final int value;
//         CounterSuccess(this.value);
//     }

//     class CounterError extends CounterState{
//         final String errorMessage;
//         CounterError(this.errorMessage);
//     }

//     // 2. the cubit business logic layer (brain)

//     class ControlCenterCubit extends Cubit<CounterState>{
//         int _count = 0;

//         // Initialize the class by sending the starting initial state to the super constructor
//         ControlCenterCubit(): super(CounterInitial());

//         // event handler 1: to increase the number
//         void incrementCounter()async{
//             // phase A: Emit a tempory loading state
//             emit(CounterLoading());

//             //simulate a tiny 400ms network layout pause
//             await Future.delayed(const Duration(milliseconds: 400));

//             if (_count >= 5){
//                 emit(CounterError('saety warning : count canot exceed 5 blocks!'));
//             }else{
//                 _count++;
//                 emit(CounterSuccess(_count));
//             }
//         }
//         void resetCounter(){
//             _count = 0;
//             emit(CounterInitial());
//         }
//     }

//     // 3. the  UI user INterface presenation screen

//     class CubitStateScreen
// }