// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'login_page.dart'; // ✅ Import the LoginPage
import 'bookingpage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Row(
          children: [
            ClipOval(
              child: Image.asset(
                "assets/images/MMBLogo.jpg",
                width: 45, // adjust width
                height: 32, // adjust height
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            const Text("MM Borewell"),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.red),
                  hintText: "Search articles...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          // Dashboard grid
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(15),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                DashboardCard(title: "Home", icon: Icons.home),
                DashboardCard(title: "Articles", icon: Icons.article),
                DashboardCard(title: "Images", icon: Icons.image),
                DashboardCard(title: "Raw Material", icon: Icons.inventory),
                DashboardCard(title: "Quotation", icon: Icons.request_quote),
                DashboardCard(
                  title: "Book",
                  icon: Icons.book_online,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Bookingpage(),
                      ),
                    );
                  },
                ),
                DashboardCard(title: "Generate Bill", icon: Icons.receipt_long),
                DashboardCard(title: "Price Details", icon: Icons.price_change),
                DashboardCard(
                  title: "More",
                  icon: FontAwesomeIcons.chessKnight,
                ),
              ],
            ),
          ),

          // Social Icons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SocialIcon(icon: FontAwesomeIcons.instagram),
                SizedBox(width: 15),
                SocialIcon(icon: FontAwesomeIcons.facebookF),
                SizedBox(width: 15),
                SocialIcon(icon: FontAwesomeIcons.whatsapp),
                SizedBox(width: 15),
                SocialIcon(icon: FontAwesomeIcons.twitter),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- DashboardCard ----------------
class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("$title clicked")));
          },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: Colors.red),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- SocialIcon ----------------
class SocialIcon extends StatelessWidget {
  final IconData icon;

  const SocialIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: Colors.red, size: 28);
  }
}

// ---------------- AppDrawer ----------------
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.red),
            child: Text(
              "MM Borewell",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.article),
            title: const Text("Articles"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text("Images"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text("Raw Material"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.request_quote),
            title: const Text("Quotation"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.book_online),
            title: const Text("Book"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text("Generate Bill"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.price_change),
            title: const Text("Price Details"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.chessKnight),
            title: const Text("More"),
            onTap: () => Navigator.pop(context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
