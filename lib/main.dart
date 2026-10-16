import 'package:flutter/material.dart';

void main() => runApp(const DirectoryApp());

// Holds fixed student information; it is a data model, not a widget.
class Student {
  final String name;
  final String course;
  final int yearLevel;
  final String email;

  const Student({
    required this.name,
    required this.course,
    required this.yearLevel,
    required this.email,
  });
}

// Hard-coded sample data required by the activity.
const List<Student> students = [
  Student(
    name: 'Ronel Silvosa',
    course: 'BS Information Technology',
    yearLevel: 3,
    email: 'ronel.silvosa@example.com',
  ),
  Student(
    name: 'Ashley Pullos',
    course: 'BS Computer Science',
    yearLevel: 3,
    email: 'ashley.pullos@example.com',
  ),
  Student(
    name: 'Tengson John Leo',
    course: 'BS Information Technology',
    yearLevel: 3,
    email: 'tengson.john.leo@example.com',
  ),
  Student(
    name: 'Denver Chavez',
    course: 'BS Information Systems',
    yearLevel: 3,
    email: 'denver.chavez@example.com',
  ),
  Student(
    name: 'Ram Fervis',
    course: 'BS Computer Science',
    yearLevel: 3,
    email: 'ram.fervis@example.com',
  ),
];

// Stateless because the app theme and home screen are fixed.
class DirectoryApp extends StatelessWidget {
  const DirectoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Customization 1: use a teal seed color for the app's Material 3 theme.
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: const DirectoryScreen(),
    );
  }
}

// Stateless because the directory displays fixed sample data without user input.
class DirectoryScreen extends StatelessWidget {
  const DirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Directory'),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(title: 'Students'),
          const SizedBox(height: 8),
          for (final student in students) StudentCard(student: student),
        ],
      ),
    );
  }
}

// Stateless because its heading is provided by the parent and never changes here.
class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          // Customization 2: use a bold, theme-colored section heading.
          style: TextStyle(
            color: colorScheme.primary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Divider(color: colorScheme.outlineVariant, thickness: 1),
      ],
    );
  }
}

// Stateless because the icon and text are supplied as fixed constructor values.
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Theme.of(context).colorScheme.secondary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// Stateless because each card only presents the Student passed by its parent.
class StudentCard extends StatelessWidget {
  final Student student;

  const StudentCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      // Customization 3: rounded card corners give each student card a softer look.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              // Customization 4: use a light theme-based avatar background.
              backgroundColor: colorScheme.primaryContainer,
              foregroundColor: colorScheme.onPrimaryContainer,
              radius: 25,
              child: Text(
                student.name[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    // Customization 5: make each student's name stand out.
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(student.course),
                  const SizedBox(height: 10),
                  InfoRow(
                    icon: Icons.school_outlined,
                    text: 'Year Level: ${student.yearLevel}',
                  ),
                  const SizedBox(height: 6),
                  InfoRow(
                    icon: Icons.email_outlined,
                    text: student.email,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
