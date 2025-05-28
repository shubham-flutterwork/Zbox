import 'package:flutter/material.dart';
import 'package:zbox_admin/auth_screen/loginscreen.dart';
import 'package:zbox_admin/pages/order_mng_screen.dart';
import 'package:zbox_admin/pages/product_mng_screen.dart';
import 'package:zbox_admin/pages/role_mng_screen.dart';
import 'package:zbox_admin/pages/user_mng_screen.dart';
import '../constants/color.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          /// --- Header ---
          Container(
            height: 160,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.blue, AppColors.blueLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://www.zbox.com/static/media/Zbox-logo.4c00118557e8db29a910.png',
                  height: 40,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 12),
                const Text(
                  'ZBox Admin Panel',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          /// --- Menu Items ---
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _DrawerItem(
                  title: 'Dashboard',
                  icon: Icons.dashboard,
                  onTap: () => Navigator.pop(context),
                ),
                _DrawerItem(
                  title: 'User Management',
                  icon: Icons.people,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserManagementScreen()),
                    );
                  },
                ),
                Divider(color: AppColors.blueLight),

                _SectionTitle('Management'),
                _DrawerItem(
                  title: 'Role Management',
                  icon: Icons.security,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RoleManagementScreen()),
                    );
                  },
                ),
                _DrawerItem(
                  title: 'Product Management',
                  icon: Icons.inventory,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductManagementScreen()),
                    );
                  },
                ),
                _DrawerItem(
                  title: 'Order Management',
                  icon: Icons.receipt_long,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderManagementScreen()),
                    );
                  },
                ),
                _DrawerItem(
                  title: 'Vendor Management',
                  icon: Icons.store,
                  onTap: () => Navigator.pop(context),
                ),
                Divider(color: AppColors.blueLight),

                _SectionTitle('Utilities'),
                _DrawerItem(
                  title: 'Content Management',
                  icon: Icons.article,
                  onTap: () => Navigator.pop(context),
                ),
                _DrawerItem(
                  title: 'Notifications',
                  icon: Icons.notifications,
                  onTap: () => Navigator.pop(context),
                ),
                _DrawerItem(
                  title: 'Reports & Logs',
                  icon: Icons.bar_chart,
                  onTap: () => Navigator.pop(context),
                ),
                _DrawerItem(
                  title: 'Settings',
                  icon: Icons.settings,
                  onTap: () => Navigator.pop(context),
                ),
                Divider(color: AppColors.blueLight),

                _DrawerItem(
                  title: 'Logout',
                  icon: Icons.logout,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                ),
              ],
            ),
          ),

          /// --- Footer ---
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.blueLight)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SocialIcon(icon: Icons.facebook, color: AppColors.blue),
                const SizedBox(width: 16),
                _SocialIcon(icon: Icons.apple, color: AppColors.red),
                const SizedBox(width: 16),
                _SocialIcon(icon: Icons.language, color: AppColors.blueLight),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.blueLight,
        child: Icon(icon, color: AppColors.blue),
      ),
      title: Text(
        title,
        style: const TextStyle(color: AppColors.blue),
      ),
      onTap: onTap,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.red, // Red for section headings
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _SocialIcon({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: color.withOpacity(0.1),
      child: Icon(icon, size: 18, color: color),
    );
  }
}
