/*1. 

),
Use code with caution.

Step 3: Write the Diary Entry Notes (A5 Page Size)

Here is your condensed note summary to log into your A5 notebook diary:

📝 Page 12: Event-Driven BLoC Pattern

• The Sink Pipeline: The UI tier remains completely blind to operational logic codes. It acts purely as a sender, injecting objects into the system engine via context.read<Bloc>().add(YourEvent()).
• on<TargetEvent>(): Replaces standard Cubit method declarations. It maps single input channels to matching processing methods inside the constructor framework.
• Predictability Advantage: Because every change requires an explicit, unique event class instance, debugging complex production applications becomes trivial—you simply look at the chronological sequence of events fired.

The Data Loop Pattern

  [ UI Component Layer ] ----( .add(Event) )----> [ BLoC Handler Axis ]
            ^                                                |

            |------------( emits(NewState) )-----------------|
 */



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//1. immutable architectural states (what the UI sees)
sealed class Enginestate {}

class EngineIdle extends Enginestate {}

class EngineProcessing extends Enginestate {}

class EngineSuccess extends Enginestate {
  final List<String> operationLogs;
  EngineSuccess(this.operationLogs);
}

class EngineFailure extends Enginestate {
  final String errorReason;
  EngineFailure(this.errorReason);
}

//2. explicit immutablr events (signals from the UI)
sealed class EngineEvent {}

class RunDataCycleEvent extends EngineEvent {
  final int batchSize;
  RunDataCycleEvent({required this.batchSize});
}

class PurgeLogsEvent extends EngineEvent {}

//3. the enterprise bloc engine (the core controller)
class AutomationBloc extends Bloc<EngineEvent, Enginestate> {
  final List<String> _internallogs = [];

  //pass the entry state map to the super class constructor

  AutomationBloc() : super(EngineIdle()) {
    //register event handler pipeline using the 'on<Event> registration API
    on<RunDataCycleEvent>(_onRunDataCycle);
    on<PurgeLogsEvent>(_onPurgeLogs);
  }

  //all event handlers receive two parameters: the Event instance and the emitter emitter
  void _onRunDataCycle(RunDataCycleEvent event, Emitter<Enginestate>emit)assync {
    emit(EngineProcessing());

    // simulatedeep backgaround data calculation or complex JSON matrix maps parsing
    await Future.delayed(const Duration(milliseconds: 700));

    if(event.batchSize <= 0){
        emit(EngineFailure('Invalid Operation: Batch data scop sizes must positive!'));
    }
    else{
        _internallogs.add('Executed compute cycle array containing ${event.batchSize} element at ${DataTime.now().toLocal()}');
    }
  }

  void _onPurgeLogs(PurgeLogsEvent event, Emitter<Enginestate> emit) {
    _internallogs.clear();
    emit(EngineIdle());
  }
}

//4. the UI widget view sector
class EventBlocScreen extends StatelessWidget {
    const EventBlocScreen({super.key});

    @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(BuildContext context) => AutomationBloc(),
        child: Scaffold(
            appBar:AppBar(
            title: const Text('event-driven bloc lab'),
            backgroundColor: Colors.purple,
            ),
            body: Padding(
                padding: const EdgeInsets.all(24.0),
                child:Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                        const Text(
                            'Enterprise command dock',
                            style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),

                            //---data visalization window (blocbuilder)---
                            Expanded(
                                child: Container(
                                    padding:const EdgeInsets.all(16.0),
                                    decoration:BoxDecoration(
                                        color:Colors.purple.withValues(),
                                        borderRadius:BorderRadius.circular(12.0),
                                        border: Border.all(color: Colors.purple.withValues()),
                                    ),
                                    child: Center(
                                        child: BlocBuilder<AutomationBloc,Enginestate>(
                                            builder: (context, state){
                                               return switch (state){
                                                EngineIdle() => const Text('system online. awaiting event vectors.', style:TextStyle(color:Colors.grey)),
                                                EngineProcessing() => const CircularProgressIndicator(color:Colors.purple),
                                                EngineFailure(:final errorReason) => Text (errorReason, style: const TextStyle(color:Colors.red, fontWeight: FontWeight.bold), textAlign:TextAlign.center),
                                                EngineSuccess(:final operationLogs) => ListView.builder(
                                                  itemCount: operationLogs.length,
                                                  itemBuilder: (context, index) => Card(
                                                    margin:const EdgeInsets.symmetric(vertical:4.0),
                                                    child:ListTile(
                                                        leading:const Icon(Icons.terminal, color:Colors.purple),
                                                        title: Text(operationLogs[index], style:const TextStyle(fontSize: 13, fontFamily:'monospace')),
                                                        
                                                    ),
                                                  ),
                                                ),
                                               };
                                            },
                                        ),
                                    ),
                                ),
                        ),
                        const SizedBox(height: 24),

                        //--Contorl Interface---
                        row(
                          children:[
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(backgaroundColor:Colors.grey[300]),
                                // Instead of calling a function , we drop an event object into the stream
                                onpressed:() => context.read<AutomationBloc>().add(PurgeLogsEvent()),
                                icon:const Icon(Icons.delete_sweep, color:Colors.black87),
                                lable: const Text('Clear System', style:TextStyle(color:Colors.black87)),
                              ),
                            ),
                            const SizedBox(width:12,
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(backgaroundColor:Colors.purple),
                                // triggering a calculation loop while explicitly package target dynamic parameter
                                onPressed: () => context.read<AutomationBloc>().add(RunDataCycleEvent(batchSize:)),
                                icon: const Icon(Icons.bolt, color:Colors.white),
                                lable: const Text(
                                  'fire Event', style:TextStyle(color:Colors.white),
                              ),
                            )),
                          ],
                        ),
                    ],
                ),
            ),
        ), 
        
    );
  }
}