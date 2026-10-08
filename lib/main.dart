import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BioDataApp());
}

class BioDataApp extends StatelessWidget {
  const BioDataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BIO-DATA',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF173F5F),
        ),
      ),
      home: const BioDataPage(),
    );
  }
}

class BioDataPage extends StatefulWidget {
  const BioDataPage({super.key});

  @override
  State<BioDataPage> createState() => _BioDataPageState();
}

class _BioDataPageState extends State<BioDataPage> {
  final fullNameController = TextEditingController();
  final birthDateController = TextEditingController();
  final ageController = TextEditingController();
  final civilStatusController = TextEditingController();
  final nationalityController = TextEditingController();
  final religionController = TextEditingController();
  final emailController = TextEditingController();
  final contactNumberController = TextEditingController();
  final addressController = TextEditingController();

  final elementaryController = TextEditingController();
  final seniorHighSchoolController = TextEditingController();
  final collegeController = TextEditingController();
  final courseController = TextEditingController();

  final skillsController = TextEditingController();

  final positionController = TextEditingController();
  final companyController = TextEditingController();
  final yearsController = TextEditingController();

  final certificationController = TextEditingController();
  final signatureController = TextEditingController();

  Uint8List? profileImage;

  final ImagePicker imagePicker = ImagePicker();

  bool isLoading = true;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      fullNameController.text = prefs.getString('fullName') ?? '';
      birthDateController.text = prefs.getString('birthDate') ?? '';
      ageController.text = prefs.getString('age') ?? '';
      civilStatusController.text =
          prefs.getString('civilStatus') ?? '';
      nationalityController.text =
          prefs.getString('nationality') ?? '';
      religionController.text = prefs.getString('religion') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      contactNumberController.text =
          prefs.getString('contactNumber') ?? '';
      addressController.text = prefs.getString('address') ?? '';

      elementaryController.text =
          prefs.getString('elementary') ?? '';
      seniorHighSchoolController.text =
          prefs.getString('seniorHighSchool') ?? '';
      collegeController.text = prefs.getString('college') ?? '';
      courseController.text = prefs.getString('course') ?? '';

      skillsController.text = prefs.getString('skills') ?? '';

      positionController.text =
          prefs.getString('position') ?? '';
      companyController.text =
          prefs.getString('company') ?? '';
      yearsController.text = prefs.getString('years') ?? '';

      certificationController.text =
          prefs.getString('certification') ?? '';
      signatureController.text =
          prefs.getString('signature') ?? '';

      final savedImage = prefs.getString('profileImage');

      if (savedImage != null && savedImage.isNotEmpty) {
        try {
          profileImage = base64Decode(savedImage);
        } catch (_) {
          profileImage = null;
        }
      }

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });

        showMessage(
          'Failed to load saved data.',
          false,
        );
      }
    }
  }

  Future<void> pickProfilePicture() async {
    try {
      final XFile? image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 80,
      );

      if (image == null) {
        return;
      }

      final bytes = await image.readAsBytes();

      if (!mounted) return;

      setState(() {
        profileImage = bytes;
      });

      showMessage(
        'Profile picture selected.',
        true,
      );
    } catch (e) {
      showMessage(
        'Unable to select picture.',
        false,
      );
    }
  }

  Future<void> saveData() async {
    if (fullNameController.text.trim().isEmpty) {
      showMessage(
        'Please enter your full name.',
        false,
      );
      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(
        'fullName',
        fullNameController.text.trim(),
      );

      await prefs.setString(
        'birthDate',
        birthDateController.text.trim(),
      );

      await prefs.setString(
        'age',
        ageController.text.trim(),
      );

      await prefs.setString(
        'civilStatus',
        civilStatusController.text.trim(),
      );

      await prefs.setString(
        'nationality',
        nationalityController.text.trim(),
      );

      await prefs.setString(
        'religion',
        religionController.text.trim(),
      );

      await prefs.setString(
        'email',
        emailController.text.trim(),
      );

      await prefs.setString(
        'contactNumber',
        contactNumberController.text.trim(),
      );

      await prefs.setString(
        'address',
        addressController.text.trim(),
      );

      await prefs.setString(
        'elementary',
        elementaryController.text.trim(),
      );

      await prefs.setString(
        'seniorHighSchool',
        seniorHighSchoolController.text.trim(),
      );

      await prefs.setString(
        'college',
        collegeController.text.trim(),
      );

      await prefs.setString(
        'course',
        courseController.text.trim(),
      );

      await prefs.setString(
        'skills',
        skillsController.text.trim(),
      );

      await prefs.setString(
        'position',
        positionController.text.trim(),
      );

      await prefs.setString(
        'company',
        companyController.text.trim(),
      );

      await prefs.setString(
        'years',
        yearsController.text.trim(),
      );

      await prefs.setString(
        'certification',
        certificationController.text.trim(),
      );

      await prefs.setString(
        'signature',
        signatureController.text.trim(),
      );

      if (profileImage != null) {
        await prefs.setString(
          'profileImage',
          base64Encode(profileImage!),
        );
      }

      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }

      showMessage(
        'Bio-Data saved successfully!',
        true,
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }

      showMessage(
        'Failed to save data.',
        false,
      );
    }
  }

  Future<void> clearData() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Clear Bio-Data'),
          content: const Text(
            'Are you sure you want to delete all saved information?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.clear();

      fullNameController.clear();
      birthDateController.clear();
      ageController.clear();
      civilStatusController.clear();
      nationalityController.clear();
      religionController.clear();
      emailController.clear();
      contactNumberController.clear();
      addressController.clear();

      elementaryController.clear();
      seniorHighSchoolController.clear();
      collegeController.clear();
      courseController.clear();

      skillsController.clear();

      positionController.clear();
      companyController.clear();
      yearsController.clear();

      certificationController.clear();
      signatureController.clear();

      setState(() {
        profileImage = null;
      });

      showMessage(
        'All saved data has been deleted.',
        true,
      );
    } catch (e) {
      showMessage(
        'Failed to clear data.',
        false,
      );
    }
  }

  Future<void> selectBirthDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selected == null) {
      return;
    }

    final day = selected.day.toString().padLeft(2, '0');
    final month = selected.month.toString().padLeft(2, '0');
    final year = selected.year.toString();

    setState(() {
      birthDateController.text = '$day/$month/$year';
    });

    final now = DateTime.now();

    int age = now.year - selected.year;

    if (now.month < selected.month ||
        (now.month == selected.month &&
            now.day < selected.day)) {
      age--;
    }

    ageController.text = age.toString();
  }

  void showMessage(
    String message,
    bool success,
  ) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 25,
        bottom: 15,
      ),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 27,
            decoration: BoxDecoration(
              color: const Color(0xFF173F5F),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF173F5F),
            ),
          ),
        ],
      ),
    );
  }

  Widget textField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    VoidCallback? onTap,
    String? hint,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFF173F5F),
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 15,
          ),
        ),
      ),
    );
  }

  Widget responsiveTwoColumns(
    BuildContext context,
    Widget left,
    Widget right,
  ) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 700) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 7),
              child: left,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 7),
              child: right,
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        left,
        right,
      ],
    );
  }

  Widget profilePicture() {
    return Column(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: profileImage != null
              ? Image.memory(
                  profileImage!,
                  fit: BoxFit.cover,
                )
              : const Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.grey,
                ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: pickProfilePicture,
          icon: const Icon(Icons.photo_library),
          label: const Text('Upload Picture'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EDF1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF173F5F),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'BIO-DATA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 1000,
                    ),
                    child: Card(
                      elevation: 3,
                      color: const Color(0xFFF4F6F8),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: profilePicture(),
                            ),

                            sectionTitle(
                              'Personal Information',
                            ),

                            textField(
                              'Full Name *',
                              fullNameController,
                              hint: 'Enter your full name',
                            ),

                            responsiveTwoColumns(
                              context,
                              textField(
                                'Birth Date',
                                birthDateController,
                                readOnly: true,
                                onTap: selectBirthDate,
                                hint: 'DD/MM/YYYY',
                              ),
                              textField(
                                'Age',
                                ageController,
                                keyboardType:
                                    TextInputType.number,
                              ),
                            ),

                            responsiveTwoColumns(
                              context,
                              textField(
                                'Civil Status',
                                civilStatusController,
                                hint: 'Single / Married',
                              ),
                              textField(
                                'Nationality',
                                nationalityController,
                                hint: 'Filipino',
                              ),
                            ),

                            responsiveTwoColumns(
                              context,
                              textField(
                                'Religion',
                                religionController,
                              ),
                              textField(
                                'Email',
                                emailController,
                                keyboardType:
                                    TextInputType.emailAddress,
                              ),
                            ),

                            responsiveTwoColumns(
                              context,
                              textField(
                                'Contact Number',
                                contactNumberController,
                                keyboardType:
                                    TextInputType.phone,
                              ),
                              textField(
                                'Address',
                                addressController,
                              ),
                            ),

                            sectionTitle(
                              'Educational Background',
                            ),

                            responsiveTwoColumns(
                              context,
                              textField(
                                'Elementary',
                                elementaryController,
                              ),
                              textField(
                                'Senior High School',
                                seniorHighSchoolController,
                              ),
                            ),

                            responsiveTwoColumns(
                              context,
                              textField(
                                'College',
                                collegeController,
                              ),
                              textField(
                                'Course / Degree',
                                courseController,
                              ),
                            ),

                            sectionTitle('Skills'),

                            textField(
                              'Skills',
                              skillsController,
                              maxLines: 4,
                              hint:
                                  'Communication, Leadership, Computer Skills, etc.',
                            ),

                            sectionTitle(
                              'Work Experience',
                            ),

                            responsiveTwoColumns(
                              context,
                              textField(
                                'Position',
                                positionController,
                              ),
                              textField(
                                'Company',
                                companyController,
                              ),
                            ),

                            textField(
                              'Years of Experience',
                              yearsController,
                              keyboardType:
                                  TextInputType.number,
                            ),

                            sectionTitle(
                              'Certification / Signature',
                            ),

                            textField(
                              'Certification',
                              certificationController,
                              maxLines: 4,
                            ),

                            textField(
                              'Signature',
                              signatureController,
                              hint: 'Type your full name',
                            ),

                            const SizedBox(height: 15),

                            Row(
                              children: [
                                Expanded(
                                  child: FilledButton.icon(
                                    onPressed:
                                        isSaving
                                            ? null
                                            : saveData,
                                    icon: isSaving
                                        ? const SizedBox(
                                            width: 18,
                                            height: 18,
                                            child:
                                                CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white,
                                            ),
                                          )
                                        : const Icon(
                                            Icons.save,
                                          ),
                                    label: Text(
                                      isSaving
                                          ? 'Saving...'
                                          : 'Save Data',
                                    ),
                                    style:
                                        FilledButton.styleFrom(
                                      backgroundColor:
                                          const Color(0xFF173F5F),
                                      foregroundColor:
                                          Colors.white,
                                      padding:
                                          const EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: clearData,
                                    icon: const Icon(
                                      Icons.delete_outline,
                                    ),
                                    label: const Text(
                                      'Clear Form',
                                    ),
                                    style:
                                        OutlinedButton.styleFrom(
                                      padding:
                                          const EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            const Text(
                              'Your information is saved locally on this device.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),

                            const SizedBox(height: 5),

                            const Text(
                              'No Firebase or online database is used.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    birthDateController.dispose();
    ageController.dispose();
    civilStatusController.dispose();
    nationalityController.dispose();
    religionController.dispose();
    emailController.dispose();
    contactNumberController.dispose();
    addressController.dispose();

    elementaryController.dispose();
    seniorHighSchoolController.dispose();
    collegeController.dispose();
    courseController.dispose();

    skillsController.dispose();

    positionController.dispose();
    companyController.dispose();
    yearsController.dispose();

    certificationController.dispose();
    signatureController.dispose();

    super.dispose();
  }
}