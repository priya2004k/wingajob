import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JobForm extends StatefulWidget {
  @override
  _JobFormState createState() => _JobFormState();
}

class _JobFormState extends State<JobForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _jobType;
  late DateTime _startDate;
  late DateTime _endDate;
  late String _location;
  late String _jobKeywords;
  List<String> _locationSuggestions = [];

  @override
  void initState() {
    super.initState();
    _jobType = 'Full-time'; // Initialize jobType
    _startDate = DateTime.now(); // Initialize startDate with current date
    _endDate = DateTime.now(); // Initialize endDate with current date
    _location = ''; // Initialize location
    _jobKeywords = ''; // Initialize jobKeywords
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DropdownButtonFormField<String>(
                value: _jobType,
                onChanged: (value) {
                  setState(() {
                    _jobType = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Job Type',
                ),
                items: ['Full-time', 'Internship']
                    .map((jobType) => DropdownMenuItem(
                          child: Text(jobType),
                          value: jobType,
                        ))
                    .toList(),
              ),
              SizedBox(height: 16.0),
              ListTile(
                title: Text('Start Date: ${_formatDate(_startDate)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _startDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _startDate = pickedDate;
                    });
                  }
                },
              ),
              ListTile(
                title: Text('End Date: ${_formatDate(_endDate)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _endDate,
                    firstDate: _startDate,
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _endDate = pickedDate;
                    });
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location'),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _fetchLocationSuggestions(value);
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
                onSaved: (value) {
                  _location = value!;
                },
              ),
              if (_locationSuggestions.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _locationSuggestions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_locationSuggestions[index]),
                      onTap: () {
                        setState(() {
                          _location = _locationSuggestions[index];
                        });
                      },
                    );
                  },
                ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Job Keywords'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter job keywords';
                  }
                  return null;
                },
                onSaved: (value) {
                  _jobKeywords = value!;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Process the gathered data (_jobType, _startDate, _endDate, _location, _jobKeywords)
                    // For now, just print the data
                    print('Job Type: $_jobType');
                    print('Start Date: $_startDate');
                    print('End Date: $_endDate');
                    print('Location: $_location');
                    print('Job Keywords: $_jobKeywords');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _fetchLocationSuggestions(String input) async {
    // String apiKey = 'AIzaSyCDt7-lvEy7a-kU-UnWdbRFGoU6oWbdrqY';
    String url = 'http://localhost:3000/places'; //'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey';

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var predictions = data['predictions'];
        setState(() {
          _locationSuggestions = predictions.map<String>((e) => e['description']).toList();
        });
      } else {
        print('Failed to fetch location suggestions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching location suggestions: $e');
    }
  }
}
