import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:nexora/data/consts/app_colors.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _loading = false;
  bool _googleInitialized = false;

  final String adminEmail = 'nexora@gmail.com';
  final String googleAdminEmail = 'bibka2601@gmail.com';

  @override
  void initState() {
    super.initState();
    _initializeGoogle();
  }

  Future<void> _initializeGoogle() async {
    if (kIsWeb) return;
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      try {
        await GoogleSignIn.instance.initialize();
        _googleInitialized = true;
      } catch (e) {
        _googleInitialized = false;
      }
    }
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _loginWithPassword() async {
    final email = _loginController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage('Введите логин и пароль');
      return;
    }

    if (email.toLowerCase() != adminEmail) {
      _showMessage('Этот аккаунт не является администратором');
      return;
    }

    setState(() => _loading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminPanelPage()),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Ошибка входа';
      if (e.code == 'invalid-credential') message = 'Неверный логин или пароль';
      else if (e.code == 'user-not-found') message = 'Пользователь не найден';
      else if (e.code == 'wrong-password') message = 'Неверный пароль';
      else if (e.code == 'invalid-email') message = 'Неверный email';
      else if (e.code == 'too-many-requests') message = 'Слишком много попыток. Попробуйте позже';
      _showMessage(message);
    } catch (e) {
      _showMessage('Произошла ошибка');
    }

    if (mounted) setState(() => _loading = false);
  }

  Future<void> _loginWithGoogle() async {
    if (!kIsWeb &&
        defaultTargetPlatform != TargetPlatform.android &&
        defaultTargetPlatform != TargetPlatform.iOS &&
        defaultTargetPlatform != TargetPlatform.macOS) {
      _showMessage('Google вход на Windows не поддерживается. Откройте Nexora в Chrome.');
      return;
    }

    setState(() => _loading = true);

    try {
      UserCredential userCredential;

      if (kIsWeb) {
        final provider = GoogleAuthProvider();
        userCredential = await FirebaseAuth.instance.signInWithPopup(provider);
      } else {
        if (!_googleInitialized) {
          _showMessage('Google авторизация не инициализирована');
          setState(() => _loading = false);
          return;
        }
        final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();
        final GoogleSignInAuthentication googleAuth = googleUser.authentication;
        final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken);
        userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      }

      final user = userCredential.user;
      if (user == null) {
        _showMessage('Не удалось получить данные пользователя');
        return;
      }

      if (user.email?.toLowerCase() != googleAdminEmail) {
        await FirebaseAuth.instance.signOut();
        _showMessage('Этот Google-аккаунт не имеет доступа к админке');
        return;
      }

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminPanelPage()),
      );
    } on FirebaseAuthException catch (e) {
      _showMessage('Ошибка Google: ${e.message ?? e.code}');
    } catch (e) {
      _showMessage('Не удалось войти через Google');
    }

    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4412A7)),
        ),
        title: const Text(
          'Администратор',
          style: TextStyle(color: Color(0xFF4412A7), fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: 430,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Nexora',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF4412A7)),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Панель администратора',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  'Войдите в аккаунт администратора',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _loginController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Логин',
                    hintText: 'Введите email',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Пароль',
                    hintText: 'Введите пароль',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _loginWithPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4412A7),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _loading
                        ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Text('Войти', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text('или', style: TextStyle(color: Colors.grey.shade500)),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),
                const SizedBox(height: 25),
                SizedBox(
                  height: 52,
                  child: OutlinedButton(
                    onPressed: _loading ? null : _loginWithGoogle,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('G', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF4412A7))),
                        SizedBox(width: 10),
                        Text('Продолжить с Google', style: TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Защищено Firebase Authentication',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================
// ПАНЕЛЬ АДМИНИСТРАТОРА
// =====================================================

class AdminPanelPage extends StatelessWidget {
  const AdminPanelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Nexora Admin',
          style: TextStyle(color: Color(0xFF4412A7), fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) Navigator.pop(context);
            },
            icon: const Icon(Icons.logout, color: Color(0xFF4412A7)),
          ),
        ],
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: FirebaseDatabase.instanceFor(
          app: FirebaseDatabase.instance.app,
          databaseURL: 'https://nexora-3261b-88f1d-default-rtdb.europe-west1.firebasedatabase.app',
        ).ref('orders').onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF4412A7)));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }
          final raw = snapshot.data?.snapshot.value;
          if (raw == null) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox_outlined, size: 64, color: Colors.black26),
                  SizedBox(height: 16),
                  Text('Заявок пока нет', style: TextStyle(color: Colors.black45, fontSize: 17)),
                ],
              ),
            );
          }
          final Map<String, dynamic> ordersMap = Map<String, dynamic>.from(raw as Map);
          final orders = ordersMap.entries.toList();
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: orders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final key = orders[index].key;
              final orderData = Map<String, dynamic>.from(orders[index].value as Map);
              return _OrderCard(orderKey: key, data: orderData);
            },
          );
        },
      ),
    );
  }
}

// =====================================================
// ORDER CARD
// =====================================================

class _OrderCard extends StatelessWidget {
  final String orderKey;
  final Map<String, dynamic> data;

  const _OrderCard({required this.orderKey, required this.data});

  Color _statusColor(String status) {
    switch (status) {
      case 'in_progress': return Colors.orange;
      case 'done': return Colors.green;
      case 'accepted': return Colors.green;
      default: return Colors.blue;
    }
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'in_progress': return 'В работе';
      case 'done': return 'Готово';
      case 'accepted': return 'Принята';
      default: return 'Новая';
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = data['status'] as String? ?? 'new';
    final isCompany = data['clientType'] == 'company';

    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (_) => _OrderDialog(orderKey: orderKey, data: data),
      ),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    data['clientName'] ?? '',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _statusColor(status).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _statusLabel(status),
                    style: TextStyle(color: _statusColor(status), fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.phone_outlined, size: 15, color: Colors.black45),
                const SizedBox(width: 5),
                Text(data['phone'] ?? '', style: const TextStyle(fontSize: 14, color: Colors.black54)),
                const SizedBox(width: 16),
                const Icon(Icons.work_outline, size: 15, color: Colors.black45),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    data['services'] ?? '',
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (isCompany && (data['companyName'] as String? ?? '').isNotEmpty) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.business_outlined, size: 15, color: Colors.black45),
                  const SizedBox(width: 5),
                  Text(data['companyName'] ?? '', style: const TextStyle(fontSize: 14, color: Colors.black54)),
                ],
              ),
            ],
            if ((data['message'] as String? ?? '').isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                data['message'] ?? '',
                style: const TextStyle(fontSize: 13, color: Colors.black45),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// =====================================================
// ORDER DIALOG
// =====================================================

class _OrderDialog extends StatelessWidget {
  final String orderKey;
  final Map<String, dynamic> data;

  const _OrderDialog({required this.orderKey, required this.data});

  @override
  Widget build(BuildContext context) {
    final status = data['status'] as String? ?? 'new';
    final isCompany = data['clientType'] == 'company';

    return AlertDialog(
      title: Text(data['clientName'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _row('Услуга', data['services'] ?? ''),
            _row('Телефон', data['phone'] ?? ''),
            _row('Тип', isCompany ? 'Компания' : 'Физлицо'),
            if (isCompany && (data['companyName'] as String? ?? '').isNotEmpty)
              _row('Компания', data['companyName'] ?? ''),
            _row('Имя', data['firstName'] ?? ''),
            _row('Фамилия', data['lastName'] ?? ''),
            if ((data['message'] as String? ?? '').isNotEmpty)
              _row('Комментарий', data['message'] ?? ''),
            _row('Статус', status),
          ],
        ),
      ),
      actions: [
        if (status == 'new' || status == 'new')
          TextButton(
            onPressed: () {
              FirebaseDatabase.instanceFor(
                      app: FirebaseDatabase.instance.app,
                      databaseURL: 'https://nexora-3261b-88f1d-default-rtdb.europe-west1.firebasedatabase.app',
                    ).ref('orders/$orderKey').update({'status': 'in_progress'});
              Navigator.pop(context);
            },
            child: const Text('Взять в работу', style: TextStyle(color: Colors.orange)),
          ),
        if (status == 'in_progress')
          TextButton(
            onPressed: () {
              FirebaseDatabase.instanceFor(
                      app: FirebaseDatabase.instance.app,
                      databaseURL: 'https://nexora-3261b-88f1d-default-rtdb.europe-west1.firebasedatabase.app',
                    ).ref('orders/$orderKey').update({'status': 'done'});
              Navigator.pop(context);
            },
            child: const Text('Готово', style: TextStyle(color: Colors.green)),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Закрыть'),
        ),
      ],
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text('$label:', style: const TextStyle(color: Colors.black45, fontSize: 13)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
