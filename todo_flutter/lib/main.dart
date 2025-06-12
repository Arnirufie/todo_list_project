import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'register_page.dart';

class ApiService {
  static const String baseUrl = "http://192.168.18.37:8000/api/tasks";

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<Task>> getTasks() async {
    final headers = await _getHeaders();
    final response = await http.get(Uri.parse(baseUrl), headers: headers);
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  Future<bool> addTask(Task task) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: headers,
      body: json.encode(task.toJson()),
    );
    return response.statusCode == 201;
  }

  Future<bool> updateTask(Task task) async {
    if (task.id == null) return false;

    final headers = await _getHeaders();
    final url = '$baseUrl/${task.id}';
    final response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: json.encode(task.toJson()),
    );
    return response.statusCode == 200;
  }

  Future<bool> toggleDone(Task task) async {
    if (task.id == null) return false;

    final headers = await _getHeaders();
    final url = '$baseUrl/${task.id}/toggle-done';
    final response = await http.patch(Uri.parse(url), headers: headers);
    return response.statusCode == 200;
  }

  Future<bool> deleteTask(int id) async {
    final headers = await _getHeaders();
    final url = '$baseUrl/$id';
    final response = await http.delete(Uri.parse(url), headers: headers);
    return response.statusCode == 200;
  }
}

  void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  runApp(MyAppStarter(token: token));
}

  class MyAppStarter extends StatelessWidget {
  final String? token;
  const MyAppStarter({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: token == null ? '/login' : '/home',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const MyApp(),
      },
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

enum MenuFilter { all, myDay, important, completed }

class _MyAppState extends State<MyApp> {
  final ApiService api = ApiService();
  List<Task> allTasks = [];
  MenuFilter selectedFilter = MenuFilter.all;

  final titleController = TextEditingController();
  final noteController = TextEditingController();
  final searchController = TextEditingController();
  String searchKeyword = '';
  DateTime? selectedDate;
  bool isImportant = false;

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      final tasks = await api.getTasks();
      setState(() {
        allTasks = tasks;
      });
    } catch (e) {
      showMessage("Error loading tasks: $e");
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  List<Task> get filteredTasks {
  final today = DateTime.now();
  List<Task> filtered;

  switch (selectedFilter) {
    case MenuFilter.myDay:
    filtered = allTasks.where((t) =>
    t.dueDate.year == today.year &&
    t.dueDate.month == today.month &&
    t.dueDate.day == today.day
  ).toList();
  break;
    case MenuFilter.important:
      filtered = allTasks.where((t) => t.isImportant).toList();
      break;
    case MenuFilter.completed:
      filtered = allTasks.where((t) => t.isDone).toList();
      break;
    case MenuFilter.all:
    default:
      filtered = allTasks;
  }

  if (searchKeyword.isNotEmpty) {
    filtered = filtered.where((t) =>
      t.title.toLowerCase().contains(searchKeyword.toLowerCase()) ||
      (t.description != null && t.description!.toLowerCase().contains(searchKeyword.toLowerCase()))
    ).toList();
  }

  filtered.sort((a, b) {
    if (a.isDone != b.isDone) return a.isDone ? 1 : -1;
    return a.dueDate.compareTo(b.dueDate);
  });

  return filtered;
}

  void showTaskDialog({Task? task}) {
    titleController.text = task?.title ?? '';
    noteController.text = task?.description ?? '';
    selectedDate = task?.dueDate;
    isImportant = task?.isImportant ?? false;

    bool isSaving = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text(task == null ? "Tambah Task" : "Edit Task"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: "Judul"),
                  ),
                  TextField(
                    controller: noteController,
                    decoration: const InputDecoration(labelText: "Catatan"),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[100]),
                    icon: const Icon(Icons.date_range, color: Colors.blue),
                    label: Text(
                      selectedDate == null
                          ? "Pilih Deadline"
                          : DateFormat('yyyy-MM-dd').format(selectedDate!),
                      style: const TextStyle(color: Colors.blue),
                    ),
                    onPressed: () async {
  final date = await showDatePicker(
    context: context,
    initialDate: selectedDate ?? DateTime.now(),
    firstDate: DateTime.now(), 
    lastDate: DateTime(2100),
  );
  if (date != null) {
    setModalState(() => selectedDate = date);
  }
},

                  ),
                  CheckboxListTile(
                    title: const Text("⭐ Tandai Penting"),
                    value: isImportant,
                    onChanged: (val) => setModalState(() => isImportant = val ?? false),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
              ElevatedButton(
                onPressed: isSaving
                    ? null
                    : () async {
                        if (titleController.text.isEmpty || selectedDate == null) {
                          showMessage("Judul dan tanggal wajib diisi");
                          return;
                        }

                        setModalState(() => isSaving = true);

                        final newTask = Task(
                          id: task?.id,
                          title: titleController.text,
                          dueDate: selectedDate!,
                          description: noteController.text,
                          isImportant: isImportant,
                          isDone: task?.isDone ?? false,
                        );

                        bool success = false;
                        try {
                          if (task == null) {
                            success = await api.addTask(newTask);
                          } else {
                            success = await api.updateTask(newTask);
                          }

                          if (success) {
                            fetchTasks();
                            Navigator.pop(context);
                          } else {
                            showMessage("Gagal menyimpan task");
                          }
                        } catch (e) {
                          showMessage("Error: $e");
                        } finally {
                          setModalState(() => isSaving = false);
                        }
                      },
                child: isSaving
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text("Simpan"),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> toggleDone(Task task) async {
  if (task.id == null) return;
  try {
    final success = await api.toggleDone(task);
    if (success) {
      fetchTasks(); // refresh task setelah toggle
    } else {
      showMessage("Gagal toggle status task");
    }
  } catch (e) {
    showMessage("Error: $e");
  }
}

  Future<void> deleteTask(Task task) async {
    if (task.id == null) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi Hapus"),
        content: const Text("Apakah kamu yakin ingin menghapus task ini?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Batal")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Hapus")),
        ],
      ),
    );

    if (confirm == true) {
      try {
        final success = await api.deleteTask(task.id!);
        if (success) {
          fetchTasks();
        } else {
          showMessage("Gagal menghapus task");
        }
      } catch (e) {
        showMessage("Error: $e");
      }
    }
  }

  Widget buildTaskItem(Task task) {
    final dateFormat = DateFormat('dd MMM yyyy');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Checkbox(value: task.isDone, onChanged: (_) => toggleDone(task)),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isDone ? TextDecoration.lineThrough : null,
            fontWeight: task.isImportant ? FontWeight.bold : FontWeight.normal,
            color: task.isDone ? Colors.grey : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description != null && task.description!.isNotEmpty)
              Text(task.description!),
            Text("Deadline: ${dateFormat.format(task.dueDate)}"),
            if (task.isDone && task.completedAt != null)
              Text("Selesai: ${dateFormat.format(task.completedAt!)}", style: const TextStyle(color: Colors.green)),
          ],
        ),
        trailing: Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    IconButton(
      icon: Icon(
        task.isImportant ? Icons.star : Icons.star_border,
        color: task.isImportant ? Colors.amber : Colors.grey,
      ),
      onPressed: () async {
        // Toggle nilai penting
        final updatedTask = Task(
          id: task.id,
          title: task.title,
          dueDate: task.dueDate,
          description: task.description,
          isImportant: !task.isImportant,  
          isDone: task.isDone,
          completedAt: task.completedAt,
        );

        final success = await api.updateTask(updatedTask);
        if (success) {
          fetchTasks(); 
        } else {
          showMessage("Gagal update status penting");
        }
      },
    ),
    IconButton(icon: const Icon(Icons.edit, color: Colors.orange), onPressed: () => showTaskDialog(task: task)),
    IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => deleteTask(task)),
          ],
        ),
      ),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              child: Text("My To-Do List", style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
          ),
          buildMenuItem("My Day", MenuFilter.myDay, Icons.today),
          buildMenuItem("Important", MenuFilter.important, Icons.star),
          buildMenuItem("Completed", MenuFilter.completed, Icons.done_all),
          buildMenuItem("All Tasks", MenuFilter.all, Icons.list),
        
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text("Logout"),
          onTap: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, '/login');
            }
          },
        ),
      ],
    ),
  );
}

  ListTile buildMenuItem(String title, MenuFilter filter, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: selectedFilter == filter,
      onTap: () {
        setState(() {
          selectedFilter = filter;
          Navigator.pop(context);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: Text(
          selectedFilter == MenuFilter.all
              ? "All Tasks"
              : selectedFilter == MenuFilter.myDay
                  ? "My Day"
                  : selectedFilter == MenuFilter.important
                      ? "Important"
                      : "Completed",
    ),
          actions: [
    IconButton(
      icon: const Icon(Icons.logout),
      tooltip: 'Logout',
      onPressed: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear(); // atau hanya remove('token');
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
    ),
  ],
),
body: RefreshIndicator(
  onRefresh: fetchTasks,
  child: Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: "Cari task...",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              searchKeyword = value;
            });
          },
        ),
      ),
      Expanded(
        child: filteredTasks.isEmpty
            ? const Center(child: Text("Tidak ada task"))
            : ListView.builder(
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  return buildTaskItem(filteredTasks[index]);
                },
              ),
      ),
    ],
  ),
),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () => showTaskDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
