import 'package:flutter/material.dart';
import '../widgets/item_card.dart';
import 'detail_screen.dart';
import '../user_profile_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // รายการสินค้าตัวอย่างของแอป Green Market
  final List<Map<String, dynamic>> _items = [
    {
      'title': 'ผักสลัดออร์แกนิก',
      'subtitle': 'สดใหม่จากฟาร์ม • ฿45 / กิโลกรัม',
      'icon': Icons.eco,
    },
    {
      'title': 'สตรอว์เบอร์รีสด',
      'subtitle': 'หวานกรอบ เกรดพรีเมียม • ฿120 / กล่อง',
      'icon': Icons.shopping_basket,
    },
    {
      'title': 'กล้วยหอมทอง',
      'subtitle': 'อุดมด้วยวิตามิน • ฿35 / หวี',
      'icon': Icons.lightbulb_outline,
    },
    {
      'title': 'มะเขือเทศเชอร์รี',
      'subtitle': 'ปลอดสารเคมี 100% • ฿50 / ถุง',
      'icon': Icons.local_florist,
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final item = _items[index];
            return ItemCard(
              title: item['title'],
              subtitle: item['subtitle'],
              icon: item['icon'],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      title: item['title'],
                      subtitle: item['subtitle'],
                    ),
                  ),
                );
              },
            );
          },
        );
      case 1:
        return const Center(
          child: Text('หน้าค้นหา'),
        );
      case 2:
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: UserProfileCard(
              name: '109Nawapon',
              email: 'nawapon@example.com',
              postsCount: 15,
              followersCount: 340,
              followingCount: 120,
            ),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Dev by 109Nawapon'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
            tooltip: 'ค้นหาสินค้า',
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('เปิดหน้าเพิ่มสินค้าใหม่'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('เพิ่มสินค้า'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'ค้นหา',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'โปรไฟล์',
          ),
        ],
      ),
    );
  }
}