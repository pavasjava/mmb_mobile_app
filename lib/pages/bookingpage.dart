import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 

class Bookingpage extends StatefulWidget {
  const Bookingpage({Key? key}) : super(key: key);

  @override
  State<Bookingpage> createState() => _BookingPageState();
}

class _BookingPageState extends State<Bookingpage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Dropdown values
  String? _selectedCity;
  String? _selectedArea;
  DateTime? _selectedDate;

  // Lists
  final List<String> _cityList = [
    'Bhubaneswar',
    'Cuttack',
    'Rourkela',
    'Sambalpur',
    'Berhampur',
    'Balasore',
  ];

  final List<String> _areaList = [
    'Old Town',
    'Jaydev Vihar',
    'Chandrashekharpur',
    'Patia',
    'Khandagiri',
    'Nayapalli',
  ];

  // Services
  final List<Map<String, dynamic>> _services = [
    {
      'name': 'DTH Borewell',
      'image': 'assets/images/dth.jpg',
      'selected': false,
    },
    {
      'name': 'In-well Borewell',
      'image': 'assets/images/In-well.jpg',
      'selected': false,
    },
    {
      'name': 'Caylix Borewell',
      'image': 'assets/images/caylix.jpg',
      'selected': false,
    },
    {
      'name': 'Rotary Borewell',
      'image': 'assets/images/rottary.jpg',
      'selected': false,
    },
    {
      'name': 'Washing',
      'image': 'assets/images/washing.jpg',
      'selected': false,
    },
    {
      'name': 'Motor Set',
      'image': 'assets/images/motorset.jpg',
      'selected': false,
    },
    {
      'name': 'Tubwell',
      'image': 'assets/images/tubwell.jpg',
      'selected': false,
    },
    {'name': 'Other', 'image': 'assets/images/Others.jpg', 'selected': false},
  ];

  // Submit button
  void _submitBooking() {
    if (_formKey.currentState!.validate()) {
      List<String> selectedServices = _services
          .where((s) => s['selected'])
          .map<String>((s) => s['name'] as String)
          .toList();

      if (selectedServices.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select at least one service.')),
        );
        return;
      }

      print("=== Booking Details ===");
      print("Name: ${_nameController.text}");
      print("Phone: ${_phoneController.text}");
      print("City: $_selectedCity");
      print("Area: $_selectedArea");
      print("Booking Date: ${_selectedDate != null ? DateFormat('dd-MM-yyyy').format(_selectedDate!) : ''}");
      print("Services: $selectedServices");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking submitted successfully!')),
      );
    }
  }

  // Date picker function
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borewell Booking'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Customer Booking Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter phone number' : null,
              ),
              const SizedBox(height: 12),

              // City Dropdown
              DropdownButtonFormField<String>(
                initialValue: _selectedCity,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                items: _cityList.map((city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value!;
                  });
                },
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please select City' : null,
              ),
              const SizedBox(height: 12),

              // Area Dropdown
              DropdownButtonFormField<String>(
                initialValue: _selectedArea,
                decoration: const InputDecoration(
                  labelText: 'Area',
                  border: OutlineInputBorder(),
                ),
                items: _areaList.map((area) {
                  return DropdownMenuItem<String>(
                    value: area,
                    child: Text(area),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedArea = value!;
                  });
                },
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please select Area' : null,
              ),
              const SizedBox(height: 12),

              // Booking Date
              InkWell(
                onTap: _pickDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Booking Date',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    _selectedDate == null
                        ? 'Select Date'
                        : DateFormat('dd-MM-yyyy').format(_selectedDate!),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 25),
              // Dynamic Service List
              // ..._services.map((service) {
              //   return Card(
              //     elevation: 2,
              //     margin: const EdgeInsets.symmetric(vertical: 5),
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10)),
              //     child: CheckboxListTile(
              //       title: Text(service['name'] as String),
              //       value: service['selected'] as bool,
              //       activeColor: Colors.teal,
              //       onChanged: (value) {
              //         setState(() {
              //           service['selected'] = value ?? false;
              //         });
              //       },
              //     ),
              //   );
              // }).toList(),
              const Text(
                'Select Borewell Services',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10),

              ..._services.map((service) {
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: Image.asset(
                      service['image'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(service['name']),
                    trailing: Checkbox(
                      value: service['selected'],
                      activeColor: Colors.teal,
                      onChanged: (value) {
                        setState(() {
                          service['selected'] = value!;
                        });
                      },
                    ),
                  ),
                );
              }).toList(),

              const SizedBox(height: 30),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.check_circle),
                  label: const Text(
                    'Submit Booking',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: _submitBooking,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}