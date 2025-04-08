import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MadeEasy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(), // Set LoginPage as the initial screen
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final String defaultUsername = 'user';
  final String defaultPassword = 'password';

  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Let’s Sign In")),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.5, // Set opacity to 50%
            child: Image.network(
              "https://i.postimg.cc/256J2SXt/etactics-inc-g3-Ps-F4-y7-ZY-unsplash.jpg",
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return const Text('Failed to load image');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome To MadeEasy!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock, color: Colors.white),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.visibility, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _passwordController.text = _passwordController.text;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ElevatedButton(
                  onPressed: () {
                    if (_nameController.text == defaultUsername && _passwordController.text == defaultPassword) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else {
                      setState(() {
                        _errorMessage = 'Incorrect username or password';
                      });
                    }
                  },
                  child: Text('Log In'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text("Don't have an account? Sign Up", style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> options = [
    {'label': 'Urgent Appointments', 'icon': Icons.access_alarm, 'page': UrgentAppointmentsPage()},
    {'label': 'Doctor Details', 'icon': Icons.memory, 'page': AIDoctorMatchingPage()},
    {'label': 'Sample Collection', 'icon': Icons.collections, 'page': null},
    {'label': 'Foreign Doctor Consultation', 'icon': Icons.language, 'page': null},
    {'label': 'Healthcare Plans', 'icon': Icons.local_hospital, 'page': null},
    {'label': 'Symptom Checker', 'icon': Icons.healing, 'page': null},
    {'label': 'Subscription', 'icon': Icons.subscriptions, 'page': null},
    {'label': 'Notifications', 'icon': Icons.notifications, 'page': null},
    {'label': 'Hotline', 'icon': Icons.phone, 'page': null},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (options[index]['page'] != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => options[index]['page'] as Widget),
                        );
                      }
                    },
                    child: Card(
                      color: Colors.blueAccent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(options[index]['icon'], size: 40, color: Colors.white),
                          SizedBox(height: 10),
                          Text(
                            options[index]['label'],
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class AIDoctorMatchingPage extends StatelessWidget {
  final List<Map<String, String>> doctors = [
    {'name': 'Dr. Emily Carter', 'specialization': 'AI Diagnostics Specialist', 'experience': '10 years', 'hospital': 'FutureCare Hospital'},
    {'name': 'Dr. Raj Patel', 'specialization': 'Neural Network Analyst', 'experience': '8 years', 'hospital': 'SmartHealth Institute'},
    {'name': 'Dr. Lisa Wong', 'specialization': 'Predictive Health Expert', 'experience': '12 years', 'hospital': 'NextGen Clinic'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AI Powered Doctor Matching")),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return Card(
            child: ListTile(
              leading: Icon(Icons.person, size: 40, color: Colors.blue),
              title: Text(doctor['name'] ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Specialization: ${doctor['specialization']}'),
                  Text('Experience: ${doctor['experience']}'),
                  Text('Hospital: ${doctor['hospital']}'),
                ],
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}

class UrgentAppointmentsPage extends StatefulWidget {
  @override
  _UrgentAppointmentsPageState createState() => _UrgentAppointmentsPageState();
}

class _UrgentAppointmentsPageState extends State<UrgentAppointmentsPage> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;
  String? _selectedDoctor;

  final List<Map<String, String>> doctors = [
    {'name': 'Dr. John Doe', 'specialization': 'Pediatric Care'},
    {'name': 'Dr. Jane Smith', 'specialization': 'Urology'},
    {'name': 'Dr. Alan Brown', 'specialization': 'Cardiology'},
    {'name': 'Dr. Lucy White', 'specialization': 'Dermatology'},
  ];

  final List<String> morningSlots = ['10:30 am', '11:00 am', '11:30 am'];
  final List<String> afternoonSlots = ['02:30 pm', '03:00 pm', '03:30 pm', '04:00 pm', '04:30 pm', '05:00 pm'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Urgent Appointments")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Select Doctor:', style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: _selectedDoctor,
              hint: Text('Select a doctor'),
              items: doctors.map((doc) {
                return DropdownMenuItem<String>(
                  value: doc['name'],
                  child: Text('${doc['name']} (${doc['specialization']})'),
                );
              }).toList(),
              onChanged: (val) => setState(() => _selectedDoctor = val),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2025),
                    );
                    if (picked != null) {
                      setState(() {
                        _selectedDate = picked;
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Morning Slots:'),
            Wrap(
              spacing: 10,
              children: morningSlots.map((slot) => ChoiceChip(
                label: Text(slot),
                selected: _selectedTime == slot,
                onSelected: (selected) => setState(() => _selectedTime = slot),
              )).toList(),
            ),
            SizedBox(height: 16),
            Text('Afternoon Slots:'),
            Wrap(
              spacing: 10,
              children: afternoonSlots.map((slot) => ChoiceChip(
                label: Text(slot),
                selected: _selectedTime == slot,
                onSelected: (selected) => setState(() => _selectedTime = slot),
              )).toList(),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (_selectedDoctor != null && _selectedTime != null) {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Thank You!'),
                      content: Text('Your appointment with $_selectedDoctor on ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year} at $_selectedTime is confirmed.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context); // Go back to previous screen
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select a doctor and time slot.')),
                  );
                }
              },
              child: Text('Confirm Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _successMessage = '';

  void _signUp() {
    if (_fullNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _contactNumberController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      setState(() {
        _successMessage = 'Sign Up Successful!';
      });
    } else {
      setState(() {
        _successMessage = 'Please fill all fields.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Let's Sign Up"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create Account!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _contactNumberController,
              decoration: InputDecoration(
                labelText: 'Contact Number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: () {
                    // Toggle password visibility
                  },
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _signUp,
              child: Text('Sign Up'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            if (_successMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _successMessage,
                  style: TextStyle(
                    color: _successMessage == 'Sign Up Successful!' ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Already have an account? Sign In", style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
