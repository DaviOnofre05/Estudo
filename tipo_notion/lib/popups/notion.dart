
import 'package:flutter/material.dart';
import 'package:flutter_application_2_list/framework/inputs/custom_text_area.dart';
import '/framework/xml.dart';
import 'package:flutter_application_2_list/componentes/theme.dart';
import 'package:table_calendar/table_calendar.dart';


class Notion extends StatefulWidget {
  const Notion({super.key});

  @override
  State<Notion> createState() => _NotionState();
}

class _NotionState extends State<Notion> {
  Xml? xmlPrincipal;

  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay){
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TestTheme.primaryColor,
        centerTitle: true,
        title: const Text('Calendario'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: _buildCalendar(),
    );
  }
  Widget _buildCalendar() {
    return Expanded(
      child: Column(
        children: [
          TableCalendar(
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, today),
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            onDaySelected: _onDaySelected,
          ),
          const Expanded(
            child: CustomTextArea(
              minLines: 15,
              maxLines: 15,
              label: 'Eventos',
            ),
          ),
        ],
      ),
    );
  }
}
