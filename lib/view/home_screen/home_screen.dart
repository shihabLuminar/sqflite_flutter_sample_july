import 'package:flutter/material.dart';
import 'package:sqflite_flutter_sample/controller/home_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await HomeScreenController.getEmployee();
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Employee Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the employee name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _designationController,
                decoration: const InputDecoration(
                  labelText: 'Employee Designation',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the employee designation';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await HomeScreenController.addEmployee(
                          name: _nameController.text,
                          designation: _designationController.text);
                      setState(() {});
                    }
                  },
                  child: const Text('Save'),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: HomeScreenController.employeesList.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () async {
                    await HomeScreenController.updateEmployee(
                        name: "updated name",
                        designation: "updated designation",
                        id: HomeScreenController.employeesList[index]["id"]);
                    setState(() {});
                  },
                  trailing: IconButton(
                      onPressed: () async {
                        await HomeScreenController.deleteEmployee(
                            HomeScreenController.employeesList[index]["id"]);
                        setState(() {});
                      },
                      icon: Icon(Icons.delete)),
                  leading: Text(HomeScreenController.employeesList[index]["id"]
                      .toString()),
                  title:
                      Text(HomeScreenController.employeesList[index]["name"]),
                  subtitle: Text(
                      HomeScreenController.employeesList[index]["designation"]),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
