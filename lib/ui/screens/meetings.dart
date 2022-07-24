library event_calendar;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_projects/models/meeting.dart';
import 'package:flutter_projects/models/schedule_meeting.dart' as schedule;
import 'package:flutter_projects/viewModels/data_source.dart';
import 'package:flutter_projects/viewModels/meeting_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

part '../widgets/color-picker.dart';

part '../widgets/timezone-picker.dart';

part 'appointment-editor.dart';

part '../widgets/resource-picker.dart';

List<Color> _colorCollection = [];
List<String> _colorNames = [];
int _selectedColorIndex = 0;
int _selectedTimeZoneIndex = 0;
int _selectedResourceIndex = 0;
List<String> _timeZoneCollection = [];
DataSource? _events;
schedule.Meeting? _selectedAppointment;
DateTime? _startDate;
TimeOfDay? _startTime;
DateTime? _endDate;
TimeOfDay? _endTime;
bool? _isAllDay;
String _subject = '';
String _notes = '';
List<CalendarResource> _employeeCollection = [];
List<String> _nameCollection = [];

class Meetings extends StatefulWidget {
  final String type;

  const Meetings({Key? key, required this.type}) : super(key: key);

  @override
  State<Meetings> createState() => _MeetingsState();
}

class _MeetingsState extends State<Meetings> {

  List<String> _eventNameCollection = [];

  @override
  void initState() {
    _addResourceDetails();
    _employeeCollection = <CalendarResource>[];
    _addResources();
    _events = DataSource(_getMeetingDetails(), _employeeCollection);
    _selectedAppointment = null;
    _selectedColorIndex = 0;
    _selectedTimeZoneIndex = 0;
    _selectedResourceIndex = 0;
    _subject = '';
    _notes = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SafeArea(
          child: widget.type == 'user'? SfCalendar(
            allowedViews: const <CalendarView>[
              CalendarView.day,
              CalendarView.workWeek,
              CalendarView.week,
              CalendarView.month,
              CalendarView.timelineDay,
              CalendarView.timelineWeek,
              CalendarView.timelineWorkWeek,
              CalendarView.timelineMonth,
              CalendarView.schedule
            ],
            view: CalendarView.day,
            dataSource: MeetingDataSource(_getDataSource()),
            monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
            onTap: _onCalendarTapped,
          ): SfCalendar(
            allowedViews: const <CalendarView>[
              CalendarView.day,
              CalendarView.workWeek,
              CalendarView.week,
              CalendarView.month,
              CalendarView.timelineDay,
              CalendarView.timelineWeek,
              CalendarView.timelineWorkWeek,
              CalendarView.timelineMonth,
              CalendarView.schedule
            ],
            view: CalendarView.day,
            dataSource: MeetingDataSource(_getDataSource()),
            monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
          ),
        )
    );
  }

  void _addResources() {
    Random random = Random();
    for (int i = 0; i < _nameCollection.length; i++) {
      _employeeCollection.add(CalendarResource(
        displayName: _nameCollection[i],
        id: '000' + i.toString(),
        color: Color.fromRGBO(
            random.nextInt(255), random.nextInt(255), random.nextInt(255), 1),
      ));
    }
  }

  void _addResourceDetails() {
    _nameCollection = <String>[];
    _nameCollection.add('John');
    _nameCollection.add('Bryan');
    _nameCollection.add('Robert');
    _nameCollection.add('Kenny');
    _nameCollection.add('Tia');
    _nameCollection.add('Theresa');
    _nameCollection.add('Edith');
    _nameCollection.add('Brooklyn');
    _nameCollection.add('James William');
    _nameCollection.add('Sophia');
    _nameCollection.add('Elena');
    _nameCollection.add('Stephen');
    _nameCollection.add('Zoey Addison');
    _nameCollection.add('Daniel');
    _nameCollection.add('Emilia');
    _nameCollection.add('Kinsley Elena');
    _nameCollection.add('Daniel');
    _nameCollection.add('William');
    _nameCollection.add('Addison');
    _nameCollection.add('Ruby');
  }

  List<schedule.Meeting> _getMeetingDetails() {
    final List<schedule.Meeting> meetingCollection = <schedule.Meeting>[];

    _nameCollection = <String>[];
    _nameCollection.add('John');
    _nameCollection.add('Bryan');
    _nameCollection.add('Robert');
    _nameCollection.add('Kenny');
    _nameCollection.add('Tia');
    _nameCollection.add('Theresa');
    _nameCollection.add('Edith');
    _nameCollection.add('Brooklyn');
    _nameCollection.add('James William');
    _nameCollection.add('Sophia');
    _nameCollection.add('Elena');
    _nameCollection.add('Stephen');
    _nameCollection.add('Zoey Addison');
    _nameCollection.add('Daniel');
    _nameCollection.add('Emilia');
    _nameCollection.add('Kinsley Elena');
    _nameCollection.add('Daniel');
    _nameCollection.add('William');
    _nameCollection.add('Addison');
    _nameCollection.add('Ruby');

    _eventNameCollection = <String>[];
    _eventNameCollection.add('General Meeting');
    _eventNameCollection.add('Plan Execution');
    _eventNameCollection.add('Project Plan');
    _eventNameCollection.add('Consulting');
    _eventNameCollection.add('Support');
    _eventNameCollection.add('Development Meeting');
    _eventNameCollection.add('Scrum');
    _eventNameCollection.add('Project Completion');
    _eventNameCollection.add('Release updates');
    _eventNameCollection.add('Performance Check');

    _colorCollection = <Color>[];
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF85461E));
    _colorCollection.add(const Color(0xFFFF00FF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));

    _colorNames = <String>[];
    _colorNames.add('Green');
    _colorNames.add('Purple');
    _colorNames.add('Red');
    _colorNames.add('Orange');
    _colorNames.add('Caramel');
    _colorNames.add('Magenta');
    _colorNames.add('Blue');
    _colorNames.add('Peach');
    _colorNames.add('Gray');

    _timeZoneCollection = <String>[];
    _timeZoneCollection.add('Default Time');
    _timeZoneCollection.add('AUS Central Standard Time');
    _timeZoneCollection.add('AUS Eastern Standard Time');
    _timeZoneCollection.add('Afghanistan Standard Time');
    _timeZoneCollection.add('Alaskan Standard Time');
    _timeZoneCollection.add('Arab Standard Time');
    _timeZoneCollection.add('Arabian Standard Time');
    _timeZoneCollection.add('Arabic Standard Time');
    _timeZoneCollection.add('Argentina Standard Time');
    _timeZoneCollection.add('Atlantic Standard Time');
    _timeZoneCollection.add('Azerbaijan Standard Time');
    _timeZoneCollection.add('Azores Standard Time');
    _timeZoneCollection.add('Bahia Standard Time');
    _timeZoneCollection.add('Bangladesh Standard Time');
    _timeZoneCollection.add('Belarus Standard Time');
    _timeZoneCollection.add('Canada Central Standard Time');
    _timeZoneCollection.add('Cape Verde Standard Time');
    _timeZoneCollection.add('Caucasus Standard Time');
    _timeZoneCollection.add('Cen. Australia Standard Time');
    _timeZoneCollection.add('Central America Standard Time');
    _timeZoneCollection.add('Central Asia Standard Time');
    _timeZoneCollection.add('Central Brazilian Standard Time');
    _timeZoneCollection.add('Central Europe Standard Time');
    _timeZoneCollection.add('Central European Standard Time');
    _timeZoneCollection.add('Central Pacific Standard Time');
    _timeZoneCollection.add('Central Standard Time');
    _timeZoneCollection.add('China Standard Time');
    _timeZoneCollection.add('Dateline Standard Time');
    _timeZoneCollection.add('E. Africa Standard Time');
    _timeZoneCollection.add('E. Australia Standard Time');
    _timeZoneCollection.add('E. South America Standard Time');
    _timeZoneCollection.add('Eastern Standard Time');
    _timeZoneCollection.add('Egypt Standard Time');
    _timeZoneCollection.add('Ekaterinburg Standard Time');
    _timeZoneCollection.add('FLE Standard Time');
    _timeZoneCollection.add('Fiji Standard Time');
    _timeZoneCollection.add('GMT Standard Time');
    _timeZoneCollection.add('GTB Standard Time');
    _timeZoneCollection.add('Georgian Standard Time');
    _timeZoneCollection.add('Greenland Standard Time');
    _timeZoneCollection.add('Greenwich Standard Time');
    _timeZoneCollection.add('Hawaiian Standard Time');
    _timeZoneCollection.add('India Standard Time');
    _timeZoneCollection.add('Iran Standard Time');
    _timeZoneCollection.add('Israel Standard Time');
    _timeZoneCollection.add('Jordan Standard Time');
    _timeZoneCollection.add('Kaliningrad Standard Time');
    _timeZoneCollection.add('Korea Standard Time');
    _timeZoneCollection.add('Libya Standard Time');
    _timeZoneCollection.add('Line Islands Standard Time');
    _timeZoneCollection.add('Magadan Standard Time');
    _timeZoneCollection.add('Mauritius Standard Time');
    _timeZoneCollection.add('Middle East Standard Time');
    _timeZoneCollection.add('Montevideo Standard Time');
    _timeZoneCollection.add('Morocco Standard Time');
    _timeZoneCollection.add('Mountain Standard Time');
    _timeZoneCollection.add('Mountain Standard Time (Mexico)');
    _timeZoneCollection.add('Myanmar Standard Time');
    _timeZoneCollection.add('N. Central Asia Standard Time');
    _timeZoneCollection.add('Namibia Standard Time');
    _timeZoneCollection.add('Nepal Standard Time');
    _timeZoneCollection.add('New Zealand Standard Time');
    _timeZoneCollection.add('Newfoundland Standard Time');
    _timeZoneCollection.add('North Asia East Standard Time');
    _timeZoneCollection.add('North Asia Standard Time');
    _timeZoneCollection.add('Pacific SA Standard Time');
    _timeZoneCollection.add('Pacific Standard Time');
    _timeZoneCollection.add('Pacific Standard Time (Mexico)');
    _timeZoneCollection.add('Pakistan Standard Time');
    _timeZoneCollection.add('Paraguay Standard Time');
    _timeZoneCollection.add('Romance Standard Time');
    _timeZoneCollection.add('Russia Time Zone 10');
    _timeZoneCollection.add('Russia Time Zone 11');
    _timeZoneCollection.add('Russia Time Zone 3');
    _timeZoneCollection.add('Russian Standard Time');
    _timeZoneCollection.add('SA Eastern Standard Time');
    _timeZoneCollection.add('SA Pacific Standard Time');
    _timeZoneCollection.add('SA Western Standard Time');
    _timeZoneCollection.add('SE Asia Standard Time');
    _timeZoneCollection.add('Samoa Standard Time');
    _timeZoneCollection.add('Singapore Standard Time');
    _timeZoneCollection.add('South Africa Standard Time');
    _timeZoneCollection.add('Sri Lanka Standard Time');
    _timeZoneCollection.add('Syria Standard Time');
    _timeZoneCollection.add('Taipei Standard Time');
    _timeZoneCollection.add('Tasmania Standard Time');
    _timeZoneCollection.add('Tokyo Standard Time');
    _timeZoneCollection.add('Tonga Standard Time');
    _timeZoneCollection.add('Turkey Standard Time');
    _timeZoneCollection.add('US Eastern Standard Time');
    _timeZoneCollection.add('US Mountain Standard Time');
    _timeZoneCollection.add('UTC');
    _timeZoneCollection.add('UTC+12');
    _timeZoneCollection.add('UTC-02');
    _timeZoneCollection.add('UTC-11');
    _timeZoneCollection.add('Ulaanbaatar Standard Time');
    _timeZoneCollection.add('Venezuela Standard Time');
    _timeZoneCollection.add('Vladivostok Standard Time');
    _timeZoneCollection.add('W. Australia Standard Time');
    _timeZoneCollection.add('W. Central Africa Standard Time');
    _timeZoneCollection.add('W. Europe Standard Time');
    _timeZoneCollection.add('West Asia Standard Time');
    _timeZoneCollection.add('West Pacific Standard Time');
    _timeZoneCollection.add('Yakutsk Standard Time');

    final Random random = Random();
    for (int i = 0; i < _employeeCollection.length; i++) {
      final List<String> _employeeIds = <String>[_employeeCollection[i].id.toString()];
      if (i == _employeeCollection.length - 1) {
        int index = random.nextInt(5);
        index = index == i ? index + 1 : index;
        _employeeIds.add(_employeeCollection[index].id.toString());
      }
      for (int j = 0; j < 4; j++) {
        final DateTime date = DateTime.now();
        int startHour = 9 + random.nextInt(6);
        startHour =
        startHour >= 13 && startHour <= 14 ? startHour + 1 : startHour;
        final DateTime _shiftStartTime =
        DateTime(date.year, date.month, date.day, startHour, 0, 0);
        meetingCollection.add(schedule.Meeting(
            from: _shiftStartTime,
            to: _shiftStartTime.add(Duration(hours: 1)),
            eventName: _eventNameCollection[random.nextInt(8)],
            background: _colorCollection[random.nextInt(8)],
            startTimeZone: '',
            endTimeZone: '',
            ids: <String>[_employeeCollection[i].id.toString()]));
      }
    }
    return meetingCollection;
  }

  void _onCalendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement != CalendarElement.calendarCell &&
        calendarTapDetails.targetElement != CalendarElement.appointment) {
      return;
    }

    _selectedAppointment = null;
    _isAllDay = false;
    _selectedColorIndex = 0;
    _selectedTimeZoneIndex = 0;
    _selectedResourceIndex = 0;
    _subject = '';
    _notes = '';

    if (calendarTapDetails.appointments != null &&
        calendarTapDetails.appointments!.length == 1) {
      final schedule.Meeting meetingDetails = calendarTapDetails.appointments![0];
      _startDate = meetingDetails.from;
      _endDate = meetingDetails.to;
      _isAllDay = meetingDetails.isAllDay;
      _selectedColorIndex = _colorCollection.indexOf(meetingDetails.background);
      _selectedTimeZoneIndex = meetingDetails.startTimeZone == ''
          ? 0
          : _timeZoneCollection.indexOf(meetingDetails.startTimeZone);
      _subject = meetingDetails.eventName == '(No title)'
          ? ''
          : meetingDetails.eventName;
      _notes = meetingDetails.description;
      _selectedResourceIndex =
          _nameCollection.indexOf(calendarTapDetails.resource!.displayName);
      _selectedAppointment = meetingDetails;
    } else {
      final DateTime? date = calendarTapDetails.date;
      _startDate = date;
      _endDate = date!.add(const Duration(hours: 1));
    }
    _startTime = TimeOfDay(hour: _startDate!.hour, minute: _startDate!.minute);
    _endTime = TimeOfDay(hour: _endDate!.hour, minute: _endDate!.minute);
    Navigator.push<Widget>(
      context,
      MaterialPageRoute(builder: (BuildContext context) => AppointmentEditor()),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(
        Meeting('Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
}
