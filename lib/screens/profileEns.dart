import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Your App Title',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Your App Title'),
//         ),
//         body: ProfileBody(),
//       ),
//     );
//   }
// }

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  String _selectedCategory = 'Cours';

  Map<String, List<String>> _data = {
    'Cours': ['Mathématiques', 'Physique', 'Chimie'],
    'Quiz': ['Quiz 1', 'Quiz 2', 'Quiz 3'],
    'Étudiants': ['Étudiant 1', 'Étudiant 2', 'Étudiant 3'],
  };

  List<String> _niveaux = ['Niveau 1', 'Niveau 2'];
  String _selectedNiveau = 'Niveau 1'; // Par défaut, sélectionnez le niveau 1

  File? _image;

  final picker = ImagePicker();

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('Aucune image sélectionnée.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        // CircleAvatar(
        //   radius: 60,
        //   backgroundImage: _image != null
        //       ? FileImage(_image!)
        //       : AssetImage('assets/teacher_photo.jpg'),
        // ),
        SizedBox(height: 10),
        Text(
          'Nom du Professeur',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          'Email du Professeur',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedCategory = 'Cours';
                  });
                },
                icon: Icon(Icons.book),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedCategory = 'Quiz';
                  });
                },
                icon: Icon(Icons.quiz),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedCategory = 'Étudiants';
                  });
                },
                icon: Icon(Icons.group),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Contenu de la catégorie $_selectedCategory',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            _createNewItem(_selectedCategory);
          },
          child: Text('Créer un $_selectedCategory'),
        ),
        SizedBox(height: 20),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemCount: _data[_selectedCategory]!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: _selectedCategory == 'Étudiants'
                          ? CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/student_photo.jpg'),
                            )
                          : _selectedCategory == 'Cours'
                              ? CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/course_photo.jpg'),
                                )
                              : _selectedCategory == 'Quiz'
                                  ? CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/quiz_photo.jpg'),
                                    )
                                  : null,
                      title: Text(_data[_selectedCategory]![index]),
                      onTap: () {
                        if (_selectedCategory == 'Étudiants') {
                          _showStudentDetails(_data[_selectedCategory]![index]);
                        } else if (_selectedCategory == 'Cours') {
                          _showCourseDetails(_data[_selectedCategory]![index]);
                        } else if (_selectedCategory == 'Quiz') {
                          _showQuizDetails(_data[_selectedCategory]![index]);
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _createNewItem(String category) {
    switch (category) {
      case 'Cours':
        _createNewCourse();
        break;
      case 'Quiz':
        _createNewQuiz();
        break;
      case 'Étudiants':
        _createNewStudent();
        break;
      default:
        break;
    }
  }

  void _showStudentDetails(String studentName) {
    // Trouver l'étudiant dans les données et extraire les détails
    // Dans cet exemple, nous allons simplement afficher les détails dans une boîte de dialogue
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Détails de l\'étudiant'),
          content:
              Text('Nom de l\'étudiant: $studentName\nAutres détails: ...'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  void _showCourseDetails(String courseName) {
    // Trouver le cours dans les données et extraire les détails
    // Dans cet exemple, nous allons simplement afficher les détails dans une boîte de dialogue
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Détails du cours'),
          content: Text('Nom du cours: $courseName\nAutres détails: ...'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  void _showQuizDetails(String quizName) {
    // Trouver le quiz dans les données et extraire les détails
    // Dans cet exemple, nous allons simplement afficher les détails dans une boîte de dialogue
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Détails du quiz'),
          content: Text('Nom du quiz: $quizName\nAutres détails: ...'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  void _createNewQuiz() async {
    final TextEditingController quizTitleController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Créer un nouveau quiz'),
          content: Column(
            children: [
              TextField(
                controller: quizTitleController,
                decoration: InputDecoration(
                  hintText: 'Entrez le titre du quiz',
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: getImage,
                child: Text('Télécharger une image'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                if (quizTitleController.text.isNotEmpty && _image != null) {
                  setState(() {
                    _data['Quiz']?.add(quizTitleController.text);
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  void _createNewStudent() async {
    String? nom;
    String? prenom;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter un nouvel étudiant'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  nom = value;
                },
                decoration: InputDecoration(
                  hintText: 'Nom',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  prenom = value;
                },
                decoration: InputDecoration(
                  hintText: 'Prénom',
                ),
              ),
              SizedBox(height: 10),
              DropdownButton<String>(
                value: _selectedNiveau,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedNiveau = newValue!;
                  });
                },
                items: _niveaux.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nom != null && prenom != null) {
                  setState(() {
                    _data['Étudiants']?.add('$nom $prenom ($_selectedNiveau)');
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  void _createNewCourse() async {
    String? nom;
    String? duree;
    File? pdfFile;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter un nouveau cours'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  nom = value;
                },
                decoration: InputDecoration(
                  hintText: 'Nom du cours',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  duree = value;
                },
                decoration: InputDecoration(
                  hintText: 'Durée (en heures)',
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf'],
                  );
                  if (result != null) {
                    pdfFile = File(result.files.single.path!);
                  }
                },
                child: Text('Sélectionner un PDF'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nom != null && duree != null && pdfFile != null) {
                  setState(() {
                    _data['Cours']?.add('$nom - Durée: $duree heures');
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }
}
