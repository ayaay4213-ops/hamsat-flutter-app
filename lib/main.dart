
import 'package:flutter/material.dart';

void main() {
  runApp(const HamsatApp());
}

class HamsatApp extends StatelessWidget {
  const HamsatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'همسات',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB58A45),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF9F0),
        fontFamily: 'Arial',
      ),
      home: const HamsatHome(),
    );
  }
}

class HamsatHome extends StatefulWidget {
  const HamsatHome({super.key});

  @override
  State<HamsatHome> createState() => _HamsatHomeState();
}

class _HamsatHomeState extends State<HamsatHome> {
  int selectedTab = 0;

  final List<String> tabs = [
    'الرئيسية',
    'اكتشف',
    'إنشاء',
    'الرسائل',
    'حسابي',
  ];

  final List<IconData> icons = [
    Icons.home_rounded,
    Icons.explore_rounded,
    Icons.add_circle_outline_rounded,
    Icons.chat_bubble_outline_rounded,
    Icons.person_outline_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFF9F0),
          title: const Text(
            'همسات',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF9A7133),
              fontSize: 27,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => showMessage('لا توجد إشعارات جديدة'),
              icon: const Icon(Icons.notifications_none_rounded),
            ),
          ],
        ),
        body: IndexedStack(
          index: selectedTab,
          children: [
            homePage(),
            discoverPage(),
            createPage(),
            messagesPage(),
            profilePage(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedTab,
          onDestinationSelected: (index) {
            setState(() => selectedTab = index);
          },
          backgroundColor: Colors.white,
          indicatorColor: const Color(0xFFF1E3CA),
          destinations: List.generate(
            tabs.length,
            (index) => NavigationDestination(
              icon: Icon(icons[index]),
              label: tabs[index],
            ),
          ),
        ),
      ),
    );
  }

  Widget homePage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFB58A45), Color(0xFF75512D)],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مرحبًا بك في همسات ✨',
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'مساحتك للتعارف والدردشة وصناعة لحظات جميلة.',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        const Text(
          'الغرف النشطة',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        roomCard('🌙', 'سهرات همسات', 'دردشة وأصدقاء جدد', '12'),
        roomCard('🎶', 'عالم الموسيقى', 'أغاني وأجواء جميلة', '8'),
        roomCard('💛', 'لمة الأحباب', 'تعارف وحديث ممتع', '16'),
        roomCard('🌹', 'استراحة القلوب', 'مساحة هادئة للجميع', '5'),
      ],
    );
  }

  Widget roomCard(
    String emoji,
    String name,
    String subtitle,
    String listeners,
  ) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 27,
          backgroundColor: const Color(0xFFF4E7D0),
          child: Text(emoji, style: const TextStyle(fontSize: 25)),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.people_alt_outlined, size: 20),
            Text(listeners),
          ],
        ),
        onTap: () => openRoom(name),
      ),
    );
  }

  Widget discoverPage() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'اكتشف همسات',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        const TextField(
          decoration: InputDecoration(
            hintText: 'ابحث عن غرفة أو موضوع...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ),
        const SizedBox(height: 20),
        roomCard('🎤', 'غرف النقاش', 'تحدث وشارك أفكارك', '9'),
        roomCard('🎵', 'غرف الأغاني', 'شارك أذواقك الموسيقية', '14'),
        roomCard('☕', 'تعارف وأصدقاء', 'تعرف على أشخاص جدد', '7'),
      ],
    );
  }

  Widget createPage() {
    final controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'إنشاء غرفة جديدة',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 18),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'اسم الغرفة',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.meeting_room_outlined),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {
              if (controller.text.trim().isEmpty) {
                showMessage('اكتبي اسم الغرفة أولًا');
              } else {
                showMessage('واجهة إنشاء الغرف تجريبية حاليًا');
              }
            },
            icon: const Icon(Icons.add),
            label: const Text('إنشاء الغرفة'),
          ),
          const SizedBox(height: 12),
          const Text(
            'ملاحظة: إنشاء الغرف والانضمام الصوتي يحتاجان إلى ربط خادم فعلي.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget messagesPage() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline, size: 65, color: Color(0xFFB58A45)),
          SizedBox(height: 12),
          Text('رسائلك ستظهر هنا', style: TextStyle(fontSize: 20)),
          SizedBox(height: 6),
          Text('ابدأ بالتعرف على أصدقاء جدد في همسات'),
        ],
      ),
    );
  }

  Widget profilePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 48,
            backgroundColor: Color(0xFFF0E0C5),
            child: Icon(
              Icons.person,
              size: 55,
              color: Color(0xFF9A7133),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'مرحبًا بك في همسات',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('ملفك الشخصي'),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () => showMessage(
              'تسجيل الحسابات يحتاج إلى إعداد خدمة مصادقة.',
            ),
            child: const Text('تسجيل الدخول'),
          ),
        ],
      ),
    );
  }

  void openRoom(String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RoomPage(roomName: name),
      ),
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class RoomPage extends StatefulWidget {
  final String roomName;

  const RoomPage({super.key, required this.roomName});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  bool microphoneOn = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.roomName)),
        body: Column(
          children: [
            const SizedBox(height: 30),
            const CircleAvatar(
              radius: 42,
              backgroundColor: Color(0xFFF0E0C5),
              child: Icon(
                Icons.groups_rounded,
                size: 45,
                color: Color(0xFF9A7133),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.roomName,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            const Expanded(
              child: Center(
                child: Text(
                  'أهلًا بك في الغرفة 💛\nالصوت الحقيقي غير مفعّل بعد.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: FilledButton.icon(
                onPressed: () {
                  setState(() => microphoneOn = !microphoneOn);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        microphoneOn
                            ? 'تم تفعيل الزر التجريبي للميكروفون'
                            : 'تم إيقاف الزر التجريبي للميكروفون',
                      ),
                    ),
                  );
                },
                icon: Icon(
                  microphoneOn ? Icons.mic : Icons.mic_off,
                ),
                label: Text(
                  microphoneOn ? 'إيقاف الميكروفون' : 'تشغيل الميكروفون',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
